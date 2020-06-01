extends Node


func add_scene(scene):
	var main = get_tree().current_scene
	var instance = scene.instance()
	main.add_child(instance)
	return instance
