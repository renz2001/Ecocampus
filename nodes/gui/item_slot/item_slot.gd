@tool
extends TextureButtonPlus
class_name ItemSlot

@export var stack_label: Label
@export var item_texture_rect: TextureRect

@export var item: Item: 
	set(value): 
		item = value
		
		update()
		if item: 
			item.stack.current_changed.connect(func(_val: float): update())

@export var drag_controller: MouseDragAreaController

var stack_label_preset: String = "x%s"


func _display_empty() -> void: 
	item_texture_rect.texture = null
	stack_label.hide()
	#printerr(self)
	#printerr(stack_label.visible)


func update() -> void: 
	if !is_node_ready(): 
		await ready
		
	if item == null: 
		_display_empty() 
		return 
		
	item_texture_rect.texture = item.model.item_icon
	if item.stack.current > 1: 
		# FIXME: Stack label doesn't show even if it says show. 
		stack_label.text = stack_label_preset % str(item.stack.current)
		stack_label.show()
	else: 
		stack_label.hide()
