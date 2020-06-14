extends Control

onready var deck: Deck = $Control/Deck
onready var deal_btn = $DealButton
var Utils = preload("res://scripts/utils.gd")
var Card = preload("res://scenes/card/card.tscn")


func _ready():
	init_deck()


func init_deck():
	var card_names = Utils.CARDS.keys()
	card_names.erase("back")
	deck.init(card_names)
	deck.shuffle()


func take_card_from_deck(is_face_up = true) -> Card:
	var card_name = deck.deal()
	if card_name == null: return null

	var card = Card.instance()
	card.init(Utils.CARDS[card_name], Utils.CARDS["back"], is_face_up)
	deck.add_child(card)
	return card



func _on_DealButton_pressed():
	var card = take_card_from_deck()

	
	var pos1 = deal_btn.rect_position + Vector2(-400, deal_btn.rect_size.y - card.rect_size.y)
	card.move_to(pos1)
	
	var card2 = take_card_from_deck()
	var pos2 = deal_btn.rect_position + Vector2(-350, deal_btn.rect_size.y - card.rect_size.y)
	card2.move_to(pos2)

