extends Node2D

var CARDS = {
	"king_diamond": preload("res://assets/cards/king_diamond.png"),
	"1_club": preload("res://assets/cards/1_club.png"),
	"1_diamond": preload("res://assets/cards/1_diamond.png"),
	"1_heart": preload("res://assets/cards/1_heart.png"),
	"1_spade": preload("res://assets/cards/1_spade.png"),
	"2_club": preload("res://assets/cards/2_club.png"),
	"2_diamond": preload("res://assets/cards/2_diamond.png"),
	"2_heart": preload("res://assets/cards/2_heart.png"),
	"2_spade": preload("res://assets/cards/2_spade.png"),
	"3_club": preload("res://assets/cards/3_club.png"),
	"3_diamond": preload("res://assets/cards/3_diamond.png"),
	"3_heart": preload("res://assets/cards/3_heart.png"),
	"3_spade": preload("res://assets/cards/3_spade.png"),
	"4_club": preload("res://assets/cards/4_club.png"),
	"4_diamond": preload("res://assets/cards/4_diamond.png"),
	"4_heart": preload("res://assets/cards/4_heart.png"),
	"4_spade": preload("res://assets/cards/4_spade.png"),
	"5_club": preload("res://assets/cards/5_club.png"),
	"5_diamond": preload("res://assets/cards/5_diamond.png"),
	"5_heart": preload("res://assets/cards/5_heart.png"),
	"5_spade": preload("res://assets/cards/5_spade.png"),
	"6_club": preload("res://assets/cards/6_club.png"),
	"6_diamond": preload("res://assets/cards/6_diamond.png"),
	"6_heart": preload("res://assets/cards/6_heart.png"),
	"6_spade": preload("res://assets/cards/6_spade.png"),
	"7_club": preload("res://assets/cards/7_club.png"),
	"7_diamond": preload("res://assets/cards/7_diamond.png"),
	"7_heart": preload("res://assets/cards/7_heart.png"),
	"7_spade": preload("res://assets/cards/7_spade.png"),
	"8_club": preload("res://assets/cards/8_club.png"),
	"8_diamond": preload("res://assets/cards/8_diamond.png"),
	"8_heart": preload("res://assets/cards/8_heart.png"),
	"8_spade": preload("res://assets/cards/8_spade.png"),
	"9_club": preload("res://assets/cards/9_club.png"),
	"9_diamond": preload("res://assets/cards/9_diamond.png"),
	"9_heart": preload("res://assets/cards/9_heart.png"),
	"9_spade": preload("res://assets/cards/9_spade.png"),
	"10_club": preload("res://assets/cards/10_club.png"),
	"10_diamond": preload("res://assets/cards/10_diamond.png"),
	"10_heart": preload("res://assets/cards/10_heart.png"),
	"10_spade": preload("res://assets/cards/10_spade.png"),
	"back": preload("res://assets/cards/back.png"),
	"jack_club": preload("res://assets/cards/jack_club.png"),
	"jack_diamond": preload("res://assets/cards/jack_diamond.png"),
	"jack_heart": preload("res://assets/cards/jack_heart.png"),
	"jack_spade": preload("res://assets/cards/jack_spade.png"),
	"king_club": preload("res://assets/cards/king_club.png"),
	"king_heart": preload("res://assets/cards/king_heart.png"),
	"king_spade": preload("res://assets/cards/king_spade.png"),
	"queen_club": preload("res://assets/cards/queen_club.png"),
	"queen_diamond": preload("res://assets/cards/queen_diamond.png"),
	"queen_heart": preload("res://assets/cards/queen_heart.png"),
	"queen_spade": preload("res://assets/cards/queen_spade.png")
}

var PngCard: PackedScene = preload("res://scenes/card/png_card.tscn")


func _ready():
	var card: TextureRect = utils.add_scene(PngCard)
	card.texture = CARDS["3_spade"]
#	var card = PngCard.instance()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
