@tool
extends Label
class_name FormattedLabel

@export var string_formatter: StringFormatter


static func create(parent: Node, format: String, _input: Array[String]) -> FormattedLabel: 
	var label: FormattedLabel = GUICollection.formatted_label.instantiate()
	label.format = format
	parent.add_child(label)
	label.input(_input)
	return label


func input(val: Array[String]) -> void: 
	text = string_formatter.input(val)
	
	
