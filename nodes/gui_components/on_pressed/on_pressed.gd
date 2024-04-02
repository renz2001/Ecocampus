extends NodeComponent
class_name OnPressedComponent

@export var control: BaseButton: set = set_control


func _ready() -> void: 
	#if control == null: 
		#printerr("%s's control is null" % self.get_parent())
		#return
	control.ready.connect(
		func(): 
			control.pressed.connect(_on_pressed)
	)


## Virtual Function
func _on_pressed() -> void: 
	pass
	
	
func set_control(value: BaseButton) -> void: 
	control = value
