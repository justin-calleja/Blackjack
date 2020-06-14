extends Node2D

var Card = preload("res://scenes/card/card.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	var card = SceneUtils.add_scene(Card)
	card.set_text("H2")


#func new_card():
#	var card = Card.instance()
#	card.set_text("H1")
#	add_child(card)
##	self.add_child(card)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
