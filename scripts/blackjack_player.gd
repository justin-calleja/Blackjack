extends "res://scripts/player.gd"


const Utils = preload("res://scripts/utils.gd")


func get_hand_values():
	var result = []
	for card in cards:
		result.append(Utils.CARDS[card.name].value)
	return result


func get_best_hand_total():
	return __get_best_hand_value(0, get_hand_values())


func __get_best_hand_total(best_total, hand_values):
	pass

