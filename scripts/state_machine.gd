#extends Node

class_name SM

enum States {
	IDLE,
	DEAL_INITIAL_HANDS,
}


enum Events {
	DEAL,
	DEAL_DONE,
	HIT,
	PLAYER_LOSE,
	PLAYER_WIN,
	STAND
}

var state = States.IDLE


const transitions = {
	[States.IDLE, Events.DEAL]: States.DEAL_INITIAL_HANDS,
	[States.DEAL_INITIAL_HANDS, Events.DEAL_DONE]: States.IDLE,
	[States.DEAL_INITIAL_HANDS, Events.DEAL_DONE]: States.IDLE,

	# [States.HIT_IN_PROGRESS, Events.HIT]: States.HIT_IN_PROGRESS,
}

var listeners = []


func subscribe(listener):
	listeners.append(listener)
	return listener


func unsubscribe(listener):
	listeners.erase(listener)
	return listener


func change_state(event):
	var transition = [state, event]
	if not transition in transitions:
		print_debug('No transition when in state: ' + str(state) + ' and given event: ' + str(event))
		return
	
	state = transitions[transition]

	for listener in listeners:
		if listener.has_method('enter_state'):
			listener.enter_state(state)
		else:
			print_debug('Listnere with no "enter_state" method')

