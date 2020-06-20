extends ColorRect
class_name Deck


const Utils = preload("res://scripts/utils.gd")
const Card = preload("res://scenes/card/card.tscn")


var all_card_names
var undealt_card_names
var dealt_card_names = []


func _init():
	var card_names = Utils.CARDS.keys()
	card_names.erase("back")
	# init(card_names)
	all_card_names = card_names
	undealt_card_names = all_card_names.duplicate()
	shuffle()

# func init(card_names = []):
# 	all_card_names = card_names
# 	undealt_card_names = all_card_names.duplicate()


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


func _take_card(is_face_up = true) -> Card:
	var card_name = deal()
	if card_name == null:
		return null

	var card = Card.instance()
	card.init(
		Utils.CARDS[card_name].png,
		Utils.CARDS["back"].png,
		is_face_up,
		Utils.CARDS[card_name].value,
		Utils.CARDS[card_name].alt_value if Utils.CARDS[card_name].has("alt_value") else 0
	)
	add_child(card)
	return card


func take_card_face_up() -> Card:
	return _take_card()


func take_card_face_down() -> Card:
	return _take_card(false)
