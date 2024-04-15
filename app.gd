extends Node

@export var main_scene: ChangeSceneComponent

func _ready() -> void: 
	## TODO: Temporary change
	AudioManager.music_player.volume_db = linear_to_db(0.3)
	main_scene.change()
	
	
