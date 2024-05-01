extends Node
class_name App

@export var main_scene: ChangeSceneComponent

func _ready() -> void: 
	
	main_scene.change()
	
	
