## When a condition is met, condition_met signal is called. Use this to set a property or something. override _condition() to create your own custom condition. You can use _condition_met() instead of the signal as well. 
extends NodeComponent
class_name ConditionalSetComponent

signal condition_met

#@export var autoload_conditions: Array[ConditionalSetCondition]
@export var disabled: bool

## Can only be updated once. 
@export var update_once: bool

## After the condition is met, the condition cannot be changed anymore. 
@export var one_shot: bool

## Checks if the condition returns the opposite instead. 
@export var inverted: bool

@export var debug: bool
@export var print_color: PrintColor: 
	set(value): 
		print_color = value
		print_color.owner = self
		

func update_condition() -> void: 
	if disabled: 
		return
	if update_once: 
		disabled = true
	if _condition(): 
		if one_shot: 
			disabled = true
		_condition_met() 
		if debug: 
			print_color.out_debug("condition met")
		condition_met.emit()


## Virtual Function: Create your conditions here. 
func _condition() -> bool: 
	return false


## Virtual Function: When the condition is met. 
func _condition_met() -> void: 
	pass

