extends TextureRect
class_name Card

onready var tween = $Tween
onready var ap: AnimationPlayer = $AnimationPlayer
export var is_face_up = false
export var front_texture: Texture
export var back_texture: Texture
export(int) var value = 0
export(int) var alt_value = 0


func init(_front_texture, _back_texture, _is_face_up = false, _value = 0, _alt_value = 0):
	front_texture = _front_texture
	back_texture = _back_texture
	value = _value
	alt_value = _alt_value
	is_face_up = _is_face_up
	if is_face_up: set_front_texture()
	else: set_back_texture()
	

func flip_front():
	ap.play("flip_front")


func flip_back():
	ap.play("flip_back")


func set_front_texture():
	texture = front_texture

	
func set_back_texture():
	texture = back_texture


func move_to(pos, duration = 0.5):
	tween.interpolate_property(
		self,
		"rect_global_position",
		self.rect_global_position,
		pos,
		duration,
		Tween.TRANS_CUBIC, Tween.EASE_OUT
	)
	tween.start()

