@tool
extends GUI
class_name ItemSlot

@export var stack_label: Label

@export var item: Item: 
	set(value): 
		item = value
		if item == null: 
			return
		if item.stack.current > 0: 
			stack_label.text = stack_label_preset % str(item.stack.current)
		else: 
			stack_label.hide()

var stack_label_preset: String = "x%s"

