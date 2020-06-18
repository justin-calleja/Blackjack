extends Button


signal clicked(text)


func _on_Button_pressed():
	emit_signal("clicked", text)
