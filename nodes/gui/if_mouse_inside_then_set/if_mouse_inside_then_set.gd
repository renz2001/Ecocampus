extends ConditionalSetPropertyComponent
class_name IfMouseInsideThenSet

@export var action: String = "tap"

var mouse_inside: bool = false


func _ready() -> void: 
	node.mouse_entered.connect(_on_mouse_entered)
	node.mouse_exited.connect(_on_mouse_exited)
	
	
func _on_mouse_entered() -> void: 
	mouse_inside = true
	
	
func _on_mouse_exited() -> void: 
	mouse_inside = false
	
	
func _condition() -> bool: 
	return mouse_inside
	
	
func _input(event: InputEvent) -> void: 
	if event.is_action_pressed(action): 
		update_condition()
		printerr(_condition())

