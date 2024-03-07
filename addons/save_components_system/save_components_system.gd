@tool
extends EditorPlugin

var autoloads: Dictionary = {
	"SaveManager": "res://addons/save_components_system/singletons/save_manager/save_manager.tscn"
}

func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	for key: String in autoloads.keys(): 
		var value: String = autoloads[key]
		add_autoload_singleton(key, value)


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	for key: String in autoloads.keys(): 
		remove_autoload_singleton(key)
