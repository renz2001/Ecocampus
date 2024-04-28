@tool
extends NodeComponent
class_name SetPivotOffsetToCenter


@export var control: Control: 
	set(value): 
		if value == null && control != null: 
			control.pivot_offset = get_half_pivot_offset(control)
		control = value
		control.pivot_offset = get_half_pivot_offset(control)


func get_half_pivot_offset(c: Control) -> Vector2: 
	return c.size / 2
	
	
