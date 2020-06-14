extends Node2D

onready var card: PngCard = $PngCard
const Utils = preload("res://scripts/utils.gd")


func _ready():
#	var club10: PngCard = card.instance()
	card.init(Utils.CARDS["10_club"], Utils.CARDS["back"], false)
	yield(get_tree().create_timer(2.0), "timeout")
	card.flip_front()
