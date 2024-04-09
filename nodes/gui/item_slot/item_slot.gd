@tool
extends TextureButtonPlus
class_name ItemSlot

@export var stack_label: Label
@export var item_texture_rect: TextureRect

@export var item: ItemStack: 
	set(value): 
		item = value
		update()
		if item: 
			item.stack.current_changed.connect(func(_a: float, _b: float): update())

@export var drag_area: MouseDragArea

var stack_label_preset: String = "x%s"


func _ready() -> void: 
	MouseDrag.dragging_started.connect(_on_dragging_started)
	MouseDrag.dragging_cancelled.connect(_on_dragging_cancelled)


func set_display_visible(val: bool) -> void: 
	item_texture_rect.visible = val
	stack_label.visible = val
	#printerr(self)
	#printerr(stack_label.visible)


func update() -> void: 
	if !is_node_ready(): 
		await ready
		
	if item == null: 
		item_texture_rect.texture = null
		drag_area.disabled = true
		return 
		
	drag_area.disabled = false
	item_texture_rect.texture = item.model.item_icon
	if item.stack.current > 1: 
		# FIXME: Stack label doesn't show even if it says show. 
		stack_label.text = stack_label_preset % str(item.stack.current)
		stack_label.show()
	else: 
		stack_label.hide()

	if MouseDrag.is_dragging: 
		set_display_visible(false)


func _on_dragging_started() -> void:
	update()
	
	
func _on_dragging_cancelled() -> void: 
	update()
	
	
