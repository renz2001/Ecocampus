@tool
extends GUI
class_name ToolsItemSlot


@export var inventory: Inventory: 
	set(value): 
		inventory = value
		if !is_node_ready(): 
			await ready
		items_container.inventory = inventory
		
@export var animation: TweenArguments
@export var icon_button: TextureButtonPlus
@export var items_container: TransparentItemSlotsContainer
@export var hbox: HBoxContainer
@export var tools_panel_clip: Panel
@export var animation_duration: float = 0.5

#FIXME: THIS IS NOT WORKING PROPERLY
var playing: bool = false

func _expand() -> void: 
	#printerr("before: ", tools_panel_clip.position.x)
	var tween: Tween = animation.create_tween(get_tree()).set_parallel(true)
	playing = true
	tween.finished.connect(
		func(): 
			playing = false
	)
	tween.tween_property(tools_panel_clip, "size:x", get_tween_length(), animation_duration)
	#printerr("to: ", tools_panel_clip.position.x - get_tween_length())
	tween.tween_property(tools_panel_clip, "position:x", tools_panel_clip.position.x - get_tween_length(), animation_duration)
	tween.play()
	
	
func _close() -> void: 
	var tween: Tween = animation.create_tween(get_tree()).set_parallel(true)
	playing = true
	tween.finished.connect(
		func(): 
			playing = false
	)
	tween.tween_property(tools_panel_clip, "size:x", 0, animation_duration)
	tween.tween_property(tools_panel_clip, "position:x", tools_panel_clip.position.x + get_tween_length(), animation_duration)
	#printerr("close: ", tools_panel_clip.position.x + get_tween_length())
	tween.play()
	
	
func get_tween_length() -> float: 
	return hbox.size.x 


func _on_icon_button_toggled(toggled_on: bool) -> void: 
	if playing: 
		return
		
	if inventory.get_tool_items().is_empty(): 
		toggled_on = false
		icon_button.set_pressed(false)
	if toggled_on: 
		_expand()
	else: 
		_close()


func _on_h_box_container_resized() -> void: 
	_update_length()
	
	
func _update_length() -> void: 
	if !icon_button.button_pressed: 
		return
		
		
	var tween: Tween = animation.create_tween(get_tree()).set_parallel(true)
	tween.tween_property(tools_panel_clip, "size:x", get_tween_length(), animation_duration)
	
	var diff: float = get_tween_length() - abs(tools_panel_clip.position.x) - 63
	#printerr(tools_panel_clip.position.x)
	#print(get_tween_length())
	#printerr("diff: ", diff)
	tween.tween_property(tools_panel_clip, "position:x", tools_panel_clip.position.x - diff, animation_duration)
	#printerr("FINAL: ", tools_panel_clip.position.x - diff)
	tween.play()
	
	