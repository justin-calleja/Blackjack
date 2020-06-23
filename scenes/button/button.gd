extends Button

onready var label = $Label
onready var ap = $AnimationPlayer


func set_label_text(txt):
	label.text = txt


func fade_in():
	ap.play("in")
	disabled = false
	visible = true
	

func fade_out():
	ap.play("out")
	disabled = true
	visible = false
