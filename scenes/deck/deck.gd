extends Node2D

var cards = []
var dealt_cards = []


func init(cards):
	self.cards = cards


func _ready():
	randomize()
	
	
#	var card = PngCard.instance()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
