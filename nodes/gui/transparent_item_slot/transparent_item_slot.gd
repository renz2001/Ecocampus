@tool
extends ItemSlot
class_name TransparentItemSlot

enum BorderState {
	NONE, 
	LEFT, 
	RIGHT, 
	BOTH
}

@export var border_state: BorderState: 
	set(value): 
		border_state = value
		if !is_node_ready(): 
			await ready
			
		match border_state: 
			BorderState.NONE: 
				left_border.hide()
				right_border.hide()
			BorderState.LEFT: 
				left_border.show()
				right_border.hide()
			BorderState.RIGHT: 
				left_border.hide()
				right_border.show()
			BorderState.BOTH: 
				left_border.hide()
				right_border.hide()
				#left_border.show()
				#right_border.show()
				
@export var left_border: MarginContainer
@export var right_border: MarginContainer
