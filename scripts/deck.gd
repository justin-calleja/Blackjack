class_name Deck

const Card = preload("res://scenes/card/card.tscn")

var all_card_names: Array
var undealt_card_names: Array
var dealt_card_names = []

# the string returned when trying to take a card but the deck is empty:
const EMPTY = "EMPTY"
# the string returned when trying to take a card by name but the deck does not contain such a card:
const NO_SUCH_CARD = "NO_SUCH_CARD"


func _init():
	randomize()


func shuffle() -> void:
	undealt_card_names.shuffle()


func reset() -> void:
	undealt_card_names = all_card_names.duplicate()
	dealt_card_names.clear()


func take_by_name(card_name: String) -> String:
	if undealt_card_names.size() == 0:
		return EMPTY
	var index = undealt_card_names.find(card_name)
	if index == -1:
		return NO_SUCH_CARD
	undealt_card_names.remove(index)
	dealt_card_names.push_back(card_name)
	return card_name


func take_from_back() -> String:
	if undealt_card_names.size() == 0:
		return EMPTY
	var card_name = undealt_card_names.pop_back()
	dealt_card_names.push_back(card_name)
	return card_name
