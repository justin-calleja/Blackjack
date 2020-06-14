extends TextureRect
class_name Card

onready var tween = $Tween
onready var ap: AnimationPlayer = $AnimationPlayer
export var is_face_up = false
export var front_texture: Texture
export var back_texture: Texture


func init(front_texture, back_texture, is_face_up = false):
	self.front_texture = front_texture
	self.back_texture = back_texture
	self.is_face_up = is_face_up
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


func move_to(pos):
	tween.interpolate_property(
		self,
		"rect_global_position",
		self.rect_global_position,
		pos,
		0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	tween.start()

