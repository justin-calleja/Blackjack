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


# func _on_leave_state():
