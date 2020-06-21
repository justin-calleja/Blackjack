const State = preload("res://addons/fsm/StateMachine.gd").State


class IdleState extends State:
	
	const ID = "idle"
	

	func _on_enter_state():
		target.hit_btn.visible = false
		target.deal_btn.visible = true



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
			target.sm.transition("player_blackjack")
		elif dealer_total == 21:
			target.sm.transition("dealer_blackjack")
		else:
			target.sm.transition("wait")


# func _on_leave_state():
