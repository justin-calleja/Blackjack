const State = preload("res://addons/fsm/StateMachine.gd").State


class IdleState extends State:
	const ID = "idle"
	

	func _on_enter_state():
		print("enter idle state")
		target.hit_btn.visible = false
		target.deal_btn.visible = true
		target.deal_btn.fade_in()



class DealInitialHandsState extends State:
	const ID = "deal_initial_hands"
		
		
	func _on_enter_state():
		target.deal_btn.fade_out()
		target.deal_initial_hands()
		var player_total = target.player.get_best_hand_total()
		var dealer_total = target.dealer.get_best_hand_total()

		if player_total == 21 and dealer_total == 21:
			target.sm.transition("draw")
		elif player_total == 21:
			target.sm.transition(PlayerBlackjackState.ID)
		elif dealer_total == 21:
			target.sm.transition(DealerBlackjackState.ID)
		else:
			yield(target.get_tree().create_timer(1), "timeout")
			target.sm.transition(PlayerInputState.ID)


class PlayerBlackjackState extends State:
	const ID = "player_blackjack"


	func _on_enter_state():
		print("enter PlayerBlackjackState. TODO: show blackjack label on player.")


	func _on_leave_state():
		print("about to leave PlayerBlackjackState. TODO: remove blackjack label from player")


class DealerBlackjackState extends State:
	const ID = "dealer_blackjack"


	func _on_enter_state():
		print("enter DealerBlackjackState. TODO: show blackjack label on dealer.")


	func _on_leave_state():
		print("about to leave DealerBlackjackState. TODO: remove blackjack label from dealer")


class PlayerInputState extends State:
	const ID = "player_input"


	func _on_enter_state():
		print("enter player_input state")
		target.hit_btn.visible = true
		target.hit_btn.fade_in()
		target.stand_btn.visible = true
		target.stand_btn.fade_in()
		target.deal_btn.fade_out()
		target.deal_btn.visible = false
