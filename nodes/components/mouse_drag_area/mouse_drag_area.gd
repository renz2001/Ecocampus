extends Area2D
class_name MouseDragArea

enum Type {
	TEXTURE_NODE, 
	POSITION
}

@export var drag_node: CanvasItem
@export var type: Type

## Use this if you want to use a control instead of a CollisionShape
@export var control: Control

@export var disabled: bool

@export var owner_node: Node

@export var drag_data_properties: Array[String]

#func grab() -> void: 
	#pass
	#

func _ready() -> void: 
	if control: 
		control.gui_input.connect(_on_gui_input)
		
		
func _on_gui_input(_event: InputEvent) -> void: 
	if disabled: 
		return
		
	if Mouse.is_just_pressed(): 
		if !MouseDrag.dragging_cancelled.is_connected(_on_dragging_cancelled): 
			MouseDrag.dragging_cancelled.connect(_on_dragging_cancelled, CONNECT_ONE_SHOT)
		if !MouseDrag.dropped.is_connected(_on_dropped): 
			MouseDrag.dropped.connect(_on_dropped, CONNECT_ONE_SHOT)
		
		MouseDrag.drag(self)
		
		
func get_drag_data() -> Dictionary: 
	var dict: Dictionary = {}
	for property: String in drag_data_properties: 
		dict[property] = owner_node.get(property)
	return dict


func empty_ownder_node_properties(): 
	for property in drag_data_properties: 
		owner_node.set(property, null)
		
		
func _on_dropped() -> void: 
	#empty_ownder_node_properties()
	pass
	
	
func _on_dragging_cancelled() -> void: 
	drag_node.show()
	
	
