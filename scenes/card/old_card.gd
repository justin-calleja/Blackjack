extends TextureRect

onready var label = $Label
#onready var label = $Label

#var label = ''
#
#func _ready():
#	label = get_node("CenterContainer/Label")

func set_text(new_text):
#	label.bbcode_text = new_text
	label.text = new_text
	print_debug('label:', label.text)
