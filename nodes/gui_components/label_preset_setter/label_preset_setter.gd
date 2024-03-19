@tool
extends NodeComponent
class_name LabelPresetSetter

@export var label: Label: 
	set(value): 
		label = value
		preset = label.text

var preset: String


func set_text(value: Array[String]) -> void: 
	label.text = preset % value
	
	
func update_preset() -> void: 
	preset = label.text

