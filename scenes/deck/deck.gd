extends ColorRect
class_name Deck

var all_card_names
var undealt_card_names
var dealt_card_names = []


func init(card_names = []):
	all_card_names = card_names
	undealt_card_names = all_card_names.duplicate()


func _ready():
	randomize()


func shuffle():
	undealt_card_names.shuffle()


func deal():
	var card_name = undealt_card_names.pop_back()
	if card_name == null:
		return null
	dealt_card_names.push_back(card_name)
	return card_name


func reset():
	undealt_card_names = all_card_names.duplicate()
	dealt_card_names.clear()

