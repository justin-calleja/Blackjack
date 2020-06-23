const State = preload("res://addons/fsm/StateMachine.gd").State


class StartState extends State:
	const ID = "start"
	

	func _on_enter_state():
		print("enter %s state" % ID)
		target.deal_btn.fade_in()


class DealInitialHandsState extends State:
	const ID = "deal_initial_hands"
		
		
	func _on_enter_state():
		print("enter %s state" % ID)
		target.deal_btn.fade_out()
		target.deal_initial_hands()

		var is_player_blackjack = target.player.has_blackjack()
		var is_dealer_blackjack = target.dealer.has_blackjack()

		if is_player_blackjack and is_dealer_blackjack:
			state_machine.transition("draw")
		elif is_player_blackjack:
			state_machine.transition(PlayerBlackjackState.ID)
		elif is_dealer_blackjack:
			state_machine.transition(DealerBlackjackState.ID)
		else:
			yield(target.get_tree().create_timer(1), "timeout")
			state_machine.transition(PlayerInputState.ID)


class PlayerBlackjackState extends State:
	const ID = "player_blackjack"


	func _on_enter_state():
		print("enter %s state" % ID)


	func _on_leave_state():
		print("leave %s state" % ID)


class DealerBlackjackState extends State:
	const ID = "dealer_blackjack"


	func _on_enter_state():
		print("enter %s state" % ID)


	func _on_leave_state():
		print("leave %s state" % ID)


class PlayerInputState extends State:
	const ID = "player_input"


	func _on_enter_state():
		print("enter %s state" % ID)
		target.hit_btn.fade_in()
		target.stand_btn.fade_in()
		target.deal_btn.fade_out()


class HitState extends State:
	const ID = "hit"


	func _on_enter_state():
		print("enter %s state" % ID)
		target.deal_card_face_up_to(target.player)
		target.player.adjust_cards()
		# TODO: check player only for blackjack...
		state_machine.transition(PlayerInputState.ID)


class StandState extends State:
	const ID = "stand"


	func _on_enter_state():
		print("enter %s state" % ID)

