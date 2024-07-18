@tool
extends GUI
class_name ToolsItemSlot


@export var inventory: Inventory
@export var animation: TweenArguments
@export var icon_button: TextureButtonPlus
@export var items_container: HBoxContainer
@export var panel_clip: ColorRect
@export var animation_duration: float = 0.5

var tween: Tween

func _on_icon_button_pressed() -> void:
	if icon_button.pressed: 
		_close()
	else: 
		_open()


func _open() -> void: 
	tween = animation.create_tween(get_tree())
	tween.tween_property(panel_clip, "size/x", get_tween_length(), animation_duration)
	
	
func _close() -> void: 
	tween.tween_property(panel_clip, "size/x", 0, animation_duration)
	
	
func get_tween_length() -> float: 
	return items_container.size.x 
