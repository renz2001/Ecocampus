@tool
extends TextureButtonPlus
class_name ItemSlot

@export var stack_label: FormattedLabel
@export var item_texture_rect: TextureRect

@export var item: ItemStack: 
	set(value): 
		if item != null && item.stack.current_changed.is_connected(_on_item_stack_current_changed): 
			#print(self)
			#print(item)
			#print("")
			item.stack.current_changed.disconnect(_on_item_stack_current_changed)
		
		item = value
		if !is_node_ready(): 
			await ready
		update()
		
		if item: 
			#printerr(self)
			#printerr(item)
			#printerr("")
			item.stack.current_changed.connect(_on_item_stack_current_changed)
		
		
@export var drag_area: MouseDragArea

var stack_label_preset: String = "x%s"


func _ready() -> void: 
	if Engine.is_editor_hint(): 
		return
	MouseDrag.dragging_started.connect(_on_dragging_started)
	MouseDrag.dragging_cancelled.connect(_on_dragging_cancelled)
	MouseDrag.dropped.connect(_on_dropped)





func set_display_visible(val: bool) -> void: 
	item_texture_rect.visible = val
	stack_label.visible = val
	#printerr(self)
	#printerr(stack_label.visible)

# FIXME: Drag and dropping succesfully to a trash can, causes all the items to disappear
func update() -> void: 
	if !is_node_ready(): 
		await ready
		
	if item == null: 
		item_texture_rect.texture = null
		stack_label.hide()
		drag_area.disabled = true
		return
		
	drag_area.disabled = false
	item_texture_rect.texture = item.model.item_icon
	
	if item.stack.current > 1: 
		# FIXME: Stack label doesn't show even if it says show. 
		stack_label.input([str(item.stack.current)])
		stack_label.show()
	else: 
		stack_label.hide()

	if MouseDrag.is_dragging && MouseDrag.drag_data.has("item") && MouseDrag.drag_data["item"] == item: 
		#printerr("%s with %s is hidden with dragging" % [self, item])
		set_display_visible(false)


func _on_item_stack_current_changed(_a: float, _b: float) -> void: 
	update()


func _on_dragging_started() -> void:
	update()
	
	
func _on_dragging_cancelled() -> void: 
	update()
	
	
func _on_dropped() -> void: 
	update()
	
func clear() -> void: 
	item = null
	
	
