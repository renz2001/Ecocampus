extends TransitionGUI
class_name MiddleTransitionGUI

enum EndCondition {
	TIMEOUT, 
	LOADING_FINISHED, 
	SIGNAL, 
	WORLD_EVENT_CALLED, 
}

@export var timer: Timer

var end_condition: EndCondition

func _play() -> void: 
	match end_condition: 
		EndCondition.TIMEOUT: 
			timer.timeout.connect(end, CONNECT_ONE_SHOT)
			timer.start()
		EndCondition.LOADING_FINISHED: 
			if SceneLoader.has_thread_load_loaded: 
				end()
				return
			SceneLoader.thread_load_loaded.connect(_on_scene_loader_load_ended, CONNECT_ONE_SHOT)
		EndCondition.SIGNAL: 
			pass
		EndCondition.WORLD_EVENT_CALLED: 
			pass


func _on_scene_loader_load_ended() -> void: 
	end()
	
	
