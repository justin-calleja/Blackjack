tool
extends Node

export (PoolVector2Array) var targets = []

func _get_configuration_warning():
	if targets.size() == 0:
		return 'Cannot have a deck with no targets to serve cards to.'
	return ''

