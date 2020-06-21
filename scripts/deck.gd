class_name Deck


const Utils = preload("res://scripts/utils.gd")
const Card = preload("res://scenes/card/card.tscn")
# the string dealt when deck is empty:
const EMPTY = "EMPTY"

var all_card_names
var undealt_card_names
var dealt_card_names = []


func _init():
	randomize()
	var card_names = Utils.CARDS.keys()
	card_names.erase("back")
	all_card_names = card_names
	undealt_card_names = all_card_names.duplicate()


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
	var card_name = __deal_card_name()
	if card_name == EMPTY:
		return null

	var card = Card.instance()
	card.init(
		card_name,
		Utils.CARDS[card_name].png,
		Utils.CARDS["back"].png,
		is_face_up
	)
	return card

