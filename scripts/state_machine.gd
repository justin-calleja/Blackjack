extends Node



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
		print_debug('No transition when in state: ' + state + ' and given event: ', + event)
		return
	
	state = transitions[transition]

	for listener in listeners:
		if listener.has_method('enter_state'):
			listener.enter_state(state)
		else:
			print_debug('Listnere with no "enter_state" method')

