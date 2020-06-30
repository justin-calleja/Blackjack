extends TextureRect
class_name Card

onready var tween: Tween = $Tween
onready var ap: AnimationPlayer = $AnimationPlayer
export var is_face_up = false
export var front_texture: Texture
export var back_texture: Texture
var id: String


func init(_id, _front_texture, _back_texture, _is_face_up = false):
	id = _id
	front_texture = _front_texture
	back_texture = _back_texture
	is_face_up = _is_face_up
	if is_face_up:
		set_front_texture()
	else:
		set_back_texture()


func get_name() -> String:
	return id


func flip() -> void:
	flip_back() if is_face_up else flip_front()


func flip_front() -> void:
	ap.play("flip_front")
	is_face_up = true


func flip_back() -> void:
	ap.play("flip_back")
	is_face_up = false


func set_front_texture() -> void:
	texture = front_texture


func set_back_texture() -> void:
	texture = back_texture


func move_to(pos, duration = 0.5) -> void:
	tween.interpolate_property(
		self,
		"rect_global_position",
		self.rect_global_position,
		pos,
		duration,
		Tween.TRANS_CUBIC,
		Tween.EASE_OUT
	)
	tween.start()


func discard():
	self.queue_free()
