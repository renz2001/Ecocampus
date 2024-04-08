extends Area2D
class_name MouseDragAreaController

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
		
		
func _on_gui_input(event: InputEvent) -> void: 
	if disabled: 
		return
		
	if Mouse.is_just_pressed(): 
		if !MouseDragServer.dragging_cancelled.is_connected(_on_dragging_cancelled): 
			MouseDragServer.dragging_cancelled.connect(_on_dragging_cancelled, CONNECT_ONE_SHOT)
		if !MouseDragServer.dragging_ended.is_connected(_on_dragging_ended): 
			MouseDragServer.dragging_ended.connect(_on_dragging_ended, CONNECT_ONE_SHOT)
		
		MouseDragServer.drag(self)
		
		
		
func get_drag_data() -> Dictionary: 
	var arr: Dictionary = {}
	for property in drag_data_properties: 
		arr[property] = owner_node.get(property)
		
	return arr


func empty_ownder_node_properties(): 
	for property in drag_data_properties: 
		owner_node.set(property, null)
		
		
func _on_dragging_ended() -> void: 
	empty_ownder_node_properties()
	
	
func _on_dragging_cancelled() -> void: 
	drag_node.show()
	
	
