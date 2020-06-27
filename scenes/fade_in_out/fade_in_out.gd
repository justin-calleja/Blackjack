extends Tween

var duration = 0.4


func init(a_duration = 0.4):
	duration = a_duration


func fade_in(obj):
	self.interpolate_property(
		obj,
		"modulate",
		obj.modulate,
		Color(1, 1, 1, 1),
		duration,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
	self.start()


func fade_out(obj):
	self.interpolate_property(
		obj,
		"modulate",
		obj.modulate,
		Color(1, 1, 1, 0),
		duration,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
	self.start()
