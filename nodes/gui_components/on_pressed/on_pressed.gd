extends NodeComponent
class_name OnPressedComponent

@export var control: BaseButton


func _ready() -> void: 
	control.ready.connect(
		func(): 
			control.pressed.connect(_on_pressed)
	)


## Virtual Function
func _on_pressed() -> void: 
	pass
	
	
