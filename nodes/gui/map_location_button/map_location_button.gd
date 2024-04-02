@tool
extends TextureButton
class_name MapLocationButton

@export var change_scene: ChangeSceneArguments: 
	set(value): 
		change_scene = value
		if Engine.is_editor_hint():
			return
		if !is_node_ready(): 
			await ready
		on_pressed_change_scene.change_scene = change_scene
		
@export var on_pressed_change_scene: OnPressedChangeScene
