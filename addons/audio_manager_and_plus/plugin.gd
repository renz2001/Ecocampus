@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_autoload_singleton("AudioManager", "res://addons/audio_manager_and_plus/nodes/singletons/managers/audio_manager/audio_manager.tscn")


func _exit_tree() -> void:
	remove_autoload_singleton("AudioManager")
	
	
