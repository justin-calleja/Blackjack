class_name Deck


const Card = preload("res://scenes/card/card.tscn")
# the string dealt when deck is empty:
const EMPTY = "EMPTY"

var all_card_names : Array
var undealt_card_names : Array
var dealt_card_names = []


func _init():
	randomize()


func shuffle() -> void:
	undealt_card_names.shuffle()


func reset() -> void:
	undealt_card_names = all_card_names.duplicate()
	dealt_card_names.clear()


func take_card_face_up() -> Card:
	return __take_card()


func take_card_face_down() -> Card:
	return __take_card(false)


func __deal_card_name() -> String:
	var card_name = undealt_card_names.pop_back()
	if card_name == null:
		return EMPTY
	dealt_card_names.push_back(card_name)
	return card_name


func __take_card(is_face_up = true) -> Card:
	print_debug("__take_card in deck.gd should be implemented in a sub-class")
	return null
