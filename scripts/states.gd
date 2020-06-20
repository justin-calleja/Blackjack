const StateMachine = preload("res://addons/godot-finite-state-machine/state_machine.gd")

# class IdleState extends "state.gd":
class IdleState extends StateMachine.State:
	
	const ID = "idle"
	

	func _on_enter_state():
		print('in on enter of idle')
		target.hit_btn.visible = false
		target.deal_btn.visible = true



# class DealInitialHandsState extends "state.gd":
class DealInitialHandsState extends StateMachine.State:

	const ID = "deal_initial_hands"
		
		
	func _on_enter_state():
		print('.....in on enter of deal init hands')
		target.deal_btn.fade_out()
		target.deal_initial_hands()


# func _on_leave_state():
