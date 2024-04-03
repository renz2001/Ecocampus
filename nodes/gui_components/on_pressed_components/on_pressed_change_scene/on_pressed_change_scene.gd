@tool
extends OnPressedComponent
class_name OnPressedChangeScene


@export var change_scene: ChangeSceneArguments: 
	set(value): 
		change_scene = value
		if !is_node_ready(): 
			await ready
		if Engine.is_editor_hint(): 
			return
		change_scene_component.set_properties(change_scene)

@export var change_scene_component: ChangeSceneComponent


func _on_pressed() -> void: 
	change_scene_component.change()

