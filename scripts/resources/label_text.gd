extends Resource
class_name LabelText

@export var format: StringFormatter
@export_multiline var texts: Array[String] = []
@export var label_settings: LabelSettings
@export var with_label_settings: bool
@export var horizontal_alignment: HorizontalAlignment
@export var vertical_alignment: VerticalAlignment 


func set_label(label: Label) -> void: 
	if !texts.is_empty(): 
		if format: 
			label.text = format.input(texts)
		else: 
			label.text = texts[0]
	if with_label_settings: 
		label.label_settings = label_settings
	label.horizontal_alignment = horizontal_alignment
	label.vertical_alignment = vertical_alignment
	
	
