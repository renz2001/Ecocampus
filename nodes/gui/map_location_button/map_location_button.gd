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
		change_scene_component.set_properties(change_scene)
		
@export var texture: Texture2D: 
	set(value): 
		texture = value
		if !is_node_ready(): 
			await ready
		texture_rect.texture = texture
		
@export var change_scene_component: ChangeSceneComponent
@export var texture_rect: TextureRect



func _on_pressed() -> void:
	change_scene_component.change()
