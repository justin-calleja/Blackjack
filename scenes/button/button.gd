extends Button

onready var label = $Label
onready var ap = $AnimationPlayer

var label_text setget set_label_text, get_label_text

func set_label_text(txt):
	label.text = txt


func get_label_text():
	return label.text


func fade_in():
	ap.play("in")
	disabled = false
	visible = true
	

func fade_out():
	ap.play("out")
	disabled = true
	visible = false
