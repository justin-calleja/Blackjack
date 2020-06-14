extends Control

onready var tween = $Tween
onready var deck: Deck = $Control/Deck
onready var deal_btn = $DealButton
var Utils = preload("res://scripts/utils.gd")
var Card = preload("res://scenes/card/card.tscn")


func _ready():
	var card_names = Utils.CARDS.keys()
	card_names.erase("back")
	deck.init(card_names)
	deck.shuffle()


func _on_DealButton_pressed():
	var card_name = deck.deal()
	if card_name == null: return

	var card = Card.instance()
	card.init(Utils.CARDS[card_name], Utils.CARDS["back"], true)
	deck.add_child(card)
	
	var pos1 = deal_btn.rect_position + Vector2(-200, 0)
	print_debug(deal_btn.rect_position)
	print_debug(card.rect_global_position)
	print_debug(deck.rect_global_position)
	tween.interpolate_property(card, "rect_position",
		card.rect_position, deal_btn.rect_global_position, 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

