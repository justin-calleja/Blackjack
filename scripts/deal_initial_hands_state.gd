extends "state.gd"


func _on_enter_state():
	print('about to deal_initial_hands....')
	target.deal_btn.fade_out()
	target.deal_initial_hands()


#func _on_leave_state():
#	target.say("I feel uneasy...")
