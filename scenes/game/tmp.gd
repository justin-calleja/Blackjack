extends Control

onready var tween = $Tween
onready var deck: Deck = $Control/Deck
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
	self.add_child(card)
	tween.interpolate_property(card, "rect_position",
		card.rect_position, Vector2(100, 100), 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

