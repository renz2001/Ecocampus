@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_autoload_singleton("WorldEventManager", "res://addons/world_event_manager/nodes/singletons/world_event_manager/world_event_manager.tscn")
	pass


func _exit_tree() -> void:
	remove_autoload_singleton("WorldEventManager")

