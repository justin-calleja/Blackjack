extends ColorRect
class_name GameOverLabel

onready var label = $Label
var label_text setget set_label_text, get_label_text


func set_label_text(text):
	label.text = text


func get_label_text():
	return label.text
