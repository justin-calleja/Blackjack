const State = preload("res://addons/fsm/StateMachine.gd").State


class StartState:
	extends State

	const ID = "start"

	func _on_enter_state():
		print("enter %s state" % ID)
		target.deal_btn.fade_in()


class DealInitialHandsState:
	extends State

	const ID = "deal_initial_hands"

	func _on_enter_state():
		print("enter %s state" % ID)
		target.player.discard_cards()
		target.dealer.discard_cards()
		target.deck.reset()
		target.deck.shuffle()

		target.deal_btn.fade_out()
		# wait for deal_initial_hands to complete...
		yield(target.deal_initial_hands(), "completed")

		var is_player_blackjack = target.player.get_hand_info().is_blackjack
		var is_dealer_blackjack = target.dealer.get_hand_info().is_blackjack

		if is_player_blackjack and is_dealer_blackjack:
			state_machine.transition(GameOverState.ID)
		elif is_player_blackjack or is_dealer_blackjack:
			state_machine.transition(GameOverState.ID)
		else:
			state_machine.transition(PlayerInputState.ID)
			yield(target.get_tree().create_timer(1), "timeout")
			target.hit_btn.fade_in()
			target.stand_btn.fade_in()


class GameOverState:
	extends State
	
	const ID = "game_over"
	
	func _on_enter_state():
		print("enter %s state" % ID)
		target.hit_btn.fade_out()
		target.stand_btn.fade_out()
		target.deal_btn.fade_in()
		# TODO: figure out who won (or if its a draw) and show labels accordingly
		var player_hand_info = target.player.get_hand_info()
		var dealer_hand_info = target.dealer.get_hand_info()
		if player_hand_info.is_bust:
			print('player is bust')
		elif dealer_hand_info.is_bust:
			print('dealer is bust')
		elif player_hand_info.is_blackjack and dealer_hand_info.is_blackjack:
			print('blackjack draw')
		elif player_hand_info.is_blackjack:
			print('player is blackjack')
		elif dealer_hand_info.is_blackjack:
			print('dealer is blackjack')
		elif player_hand_info.best_hand_total > dealer_hand_info.best_hand_total:
			print('player wins')
		elif player_hand_info.best_hand_total < dealer_hand_info.best_hand_total:
			print('dealer wins')
		elif player_hand_info.best_hand_total == dealer_hand_info.best_hand_total:
			print('draw')
		
		state_machine.transition(PlayerInputState.ID)
		

class PlayerInputState:
	extends State

	const ID = "player_input"

	func _on_enter_state():
		print("enter %s state" % ID)
#		target.hit_btn.fade_in()
#		target.stand_btn.fade_in()
#		target.deal_btn.fade_out()


class HitState:
	extends State

	const ID = "hit"

	func _on_enter_state():
		print("enter %s state" % ID)
		target.move_card_from_deck_to_position(
			target.player.take_card_face_up(), target.player.get_next_card_position()
		)
		target.player.adjust_cards()

		var player_hand_info = target.player.get_hand_info()
		if player_hand_info.is_blackjack:
			state_machine.transition(GameOverState.ID)
		elif player_hand_info.is_bust:
			state_machine.transition(GameOverState.ID)
		else:
			state_machine.transition(PlayerInputState.ID)


class StandState:
	extends State

	const ID = "stand"

	func _on_enter_state():
		print("enter %s state" % ID)


