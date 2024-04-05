extends NodeComponent
class_name OnPressedComponent

signal pressed

@export var control: BaseButton: set = set_control


func _ready() -> void: 
	#if control == null: 
		#printerr("%s's control is null" % self.get_parent())
		#return
	if control: 
		control.ready.connect(
			func(): 
				control.pressed.connect(_on_control_pressed)
		)


func _on_control_pressed() -> void: 
	_on_pressed()
	pressed.emit()


## Virtual Function
func _on_pressed() -> void: 
	pass
	
	
func set_control(value: BaseButton) -> void: 
	control = value
