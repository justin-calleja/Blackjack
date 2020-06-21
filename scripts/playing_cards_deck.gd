extends "res://scripts/deck.gd"
class_name PlayingCardsDeck


func _init():
	var card_names = CARD_IMAGES.keys()
	card_names.erase("back")
	all_card_names = card_names
	undealt_card_names = all_card_names.duplicate()


func __take_card(is_face_up = true) -> Card:
	var card_name = __deal_card_name()
	if card_name == EMPTY:
		return null

	var card = Card.instance()
	card.init(card_name, CARD_IMAGES[card_name].png, CARD_IMAGES["back"].png, is_face_up)
	return card


const CARD_IMAGES = {
	"1_club":
	{
		"png": preload("res://assets/cards/1_club.png"),
	},
	"1_diamond":
	{
		"png": preload("res://assets/cards/1_diamond.png"),
	},
	"1_heart":
	{
		"png": preload("res://assets/cards/1_heart.png"),
	},
	"1_spade":
	{
		"png": preload("res://assets/cards/1_spade.png"),
	},
	"2_club":
	{
		"png": preload("res://assets/cards/2_club.png"),
	},
	"2_diamond":
	{
		"png": preload("res://assets/cards/2_diamond.png"),
	},
	"2_heart":
	{
		"png": preload("res://assets/cards/2_heart.png"),
	},
	"2_spade":
	{
		"png": preload("res://assets/cards/2_spade.png"),
	},
	"3_club":
	{
		"png": preload("res://assets/cards/3_club.png"),
	},
	"3_diamond":
	{
		"png": preload("res://assets/cards/3_diamond.png"),
	},
	"3_heart":
	{
		"png": preload("res://assets/cards/3_heart.png"),
	},
	"3_spade":
	{
		"png": preload("res://assets/cards/3_spade.png"),
	},
	"4_club":
	{
		"png": preload("res://assets/cards/4_club.png"),
	},
	"4_diamond":
	{
		"png": preload("res://assets/cards/4_diamond.png"),
	},
	"4_heart":
	{
		"png": preload("res://assets/cards/4_heart.png"),
	},
	"4_spade":
	{
		"png": preload("res://assets/cards/4_spade.png"),
	},
	"5_club":
	{
		"png": preload("res://assets/cards/5_club.png"),
	},
	"5_diamond":
	{
		"png": preload("res://assets/cards/5_diamond.png"),
	},
	"5_heart":
	{
		"png": preload("res://assets/cards/5_heart.png"),
	},
	"5_spade":
	{
		"png": preload("res://assets/cards/5_spade.png"),
	},
	"6_club":
	{
		"png": preload("res://assets/cards/6_club.png"),
	},
	"6_diamond":
	{
		"png": preload("res://assets/cards/6_diamond.png"),
	},
	"6_heart":
	{
		"png": preload("res://assets/cards/6_heart.png"),
	},
	"6_spade":
	{
		"png": preload("res://assets/cards/6_spade.png"),
	},
	"7_club":
	{
		"png": preload("res://assets/cards/7_club.png"),
	},
	"7_diamond":
	{
		"png": preload("res://assets/cards/7_diamond.png"),
	},
	"7_heart":
	{
		"png": preload("res://assets/cards/7_heart.png"),
	},
	"7_spade":
	{
		"png": preload("res://assets/cards/7_spade.png"),
	},
	"8_club":
	{
		"png": preload("res://assets/cards/8_club.png"),
	},
	"8_diamond":
	{
		"png": preload("res://assets/cards/8_diamond.png"),
	},
	"8_heart":
	{
		"png": preload("res://assets/cards/8_heart.png"),
	},
	"8_spade":
	{
		"png": preload("res://assets/cards/8_spade.png"),
	},
	"9_club":
	{
		"png": preload("res://assets/cards/9_club.png"),
	},
	"9_diamond":
	{
		"png": preload("res://assets/cards/9_diamond.png"),
	},
	"9_heart":
	{
		"png": preload("res://assets/cards/9_heart.png"),
	},
	"9_spade":
	{
		"png": preload("res://assets/cards/9_spade.png"),
	},
	"10_club":
	{
		"png": preload("res://assets/cards/10_club.png"),
	},
	"10_diamond":
	{
		"png": preload("res://assets/cards/10_diamond.png"),
	},
	"10_heart":
	{
		"png": preload("res://assets/cards/10_heart.png"),
	},
	"10_spade":
	{
		"png": preload("res://assets/cards/10_spade.png"),
	},
	"back":
	{
		"png": preload("res://assets/cards/back.png"),
	},
	"jack_club":
	{
		"png": preload("res://assets/cards/jack_club.png"),
	},
	"jack_diamond":
	{
		"png": preload("res://assets/cards/jack_diamond.png"),
	},
	"jack_heart":
	{
		"png": preload("res://assets/cards/jack_heart.png"),
	},
	"jack_spade":
	{
		"png": preload("res://assets/cards/jack_spade.png"),
	},
	"king_club":
	{
		"png": preload("res://assets/cards/king_club.png"),
	},
	"king_diamond":
	{
		"png": preload("res://assets/cards/king_diamond.png"),
	},
	"king_heart":
	{
		"png": preload("res://assets/cards/king_heart.png"),
	},
	"king_spade":
	{
		"png": preload("res://assets/cards/king_spade.png"),
	},
	"queen_club":
	{
		"png": preload("res://assets/cards/queen_club.png"),
	},
	"queen_diamond":
	{
		"png": preload("res://assets/cards/queen_diamond.png"),
	},
	"queen_heart":
	{
		"png": preload("res://assets/cards/queen_heart.png"),
	},
	"queen_spade":
	{
		"png": preload("res://assets/cards/queen_spade.png"),
	},
}
