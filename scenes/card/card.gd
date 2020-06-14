extends TextureRect
class_name Card


onready var ap: AnimationPlayer = $AnimationPlayer
export var is_front = false
export var front_texture: Texture
export var back_texture: Texture


func init(front_texture, back_texture, is_front = false):
	self.front_texture = front_texture
	self.back_texture = back_texture
	self.is_front = is_front
	if is_front: set_front_texture()
	else: set_back_texture()
	

func flip_front():
	ap.play("flip_front")


func flip_back():
	ap.play("flip_back")


func set_front_texture():
	texture = front_texture

	
func set_back_texture():
	texture = back_texture
