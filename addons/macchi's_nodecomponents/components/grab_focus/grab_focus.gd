extends NodeComponent


@export var control: Control: 
	set(value): 
		control = value
		if !control.is_node_ready(): 
			await control.ready
		control.grab_focus() 
