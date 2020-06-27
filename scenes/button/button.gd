extends Button

onready var label = $Label

var label_text setget set_label_text, get_label_text
var tween: Tween = null setget set_tween


func set_label_text(txt):
	label.text = txt


func get_label_text():
	return label.text


func set_tween(a_tween):
	if tween:
		tween.queue_free()
	tween = a_tween
	self.add_child(tween)
	print('done adding tween...')


func fade_in():
	if tween:
		tween.fade_in(self)
	disabled = false
	visible = true


func fade_out():
	if tween:
		tween.fade_out(self)
	disabled = true
	visible = false
