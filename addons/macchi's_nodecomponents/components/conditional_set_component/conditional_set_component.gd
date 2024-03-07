## When a condition is met, condition_met signal is called. Use this to set a property or something. override _condition() to create your own custom condition. You can use _condition_met() instead of the signal as well. 
extends NodeComponent
class_name ConditionalSetComponent

signal condition_met

#@export var autoload_conditions: Array[ConditionalSetCondition]
@export var disabled: bool
@export var update_once: bool
@export var one_shot: bool


func update_condition() -> void: 
	if disabled: 
		return
	if update_once: 
		disabled = true
	if _condition(): 
		if one_shot: 
			disabled = true
		_condition_met() 
		condition_met.emit()


## Virtual Function: Create your conditions here. 
func _condition() -> bool: 
	return false


## Virtual Function: When the condition is met. 
func _condition_met() -> void: 
	pass

