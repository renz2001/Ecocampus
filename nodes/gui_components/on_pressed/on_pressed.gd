extends NodeComponent
class_name OnPressedComponent

@export var control: Control

	
func _ready() -> void: 
	control.ready.connect(_on_pressed)


## Virtual Function
func _on_pressed() -> void: 
	pass
	
	
