extends BaseLabelText
class_name RichLabelText

@export var format: StringFormatter
@export_multiline var texts: Array[String] = []

func set_label(label: RichTextLabel) -> void: 
	if !texts.is_empty(): 
		if format: 
			label.text = format.input(texts)
		else: 
			label.text = texts[0]

