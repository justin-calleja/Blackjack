const State = preload("res://addons/fsm/StateMachine.gd").State


class DealInitialHandsState:
	extends State

	const ID = "deal_initial_hands"

	func _on_enter_state():
		print("enter %s state" % ID)
		target.player.hide_game_over_label()
		target.dealer.hide_game_over_label()
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
		var player_hand_info = target.player.get_hand_info()
		var dealer_hand_info = target.dealer.get_hand_info()
		if player_hand_info.is_bust:
			print('player is bust')
			target.player.show_bust_label()
		elif dealer_hand_info.is_bust:
			print('dealer is bust')
			target.dealer.show_bust_label()
		elif player_hand_info.is_blackjack and dealer_hand_info.is_blackjack:
			print('blackjack draw')
			target.player.show_draw_label()
			target.dealer.show_draw_label()
		elif player_hand_info.is_blackjack:
			print('player is blackjack')
			target.player.show_blackjack_label()
		elif dealer_hand_info.is_blackjack:
			print('dealer is blackjack')
			target.dealer.show_blackjack_label()
		elif player_hand_info.best_hand_total > dealer_hand_info.best_hand_total:
			print('player wins')
			target.player.show_win_label()
			target.dealer.show_lose_label()
		elif player_hand_info.best_hand_total < dealer_hand_info.best_hand_total:
			print('dealer wins')
			target.player.show_lose_label()
			target.dealer.show_win_label()
		elif player_hand_info.best_hand_total == dealer_hand_info.best_hand_total:
			print('draw')
			target.player.show_draw_label()
			target.dealer.show_draw_label()

		state_machine.transition(PlayerInputState.ID)


class PlayerInputState:
	extends State

	const ID = "player_input"

	func _on_enter_state():
		print("enter %s state" % ID)


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
		if player_hand_info.is_blackjack or player_hand_info.is_bust:
			state_machine.transition(GameOverState.ID)
		else:
			state_machine.transition(PlayerInputState.ID)


class StandState:
	extends State

	const ID = "stand"

	func _on_enter_state():
		print("enter %s state" % ID)
		target.dealer.flip_card_at_index(1)
		while not target.dealer.get_hand_info().should_dealer_stand:
			target.move_card_from_deck_to_position(
				target.dealer.take_card_face_up(), target.dealer.get_next_card_position()
			)
			target.dealer.adjust_cards()

		state_machine.transition(GameOverState.ID)
