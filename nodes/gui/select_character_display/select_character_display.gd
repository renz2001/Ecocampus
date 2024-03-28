@tool
extends CenterContainer
class_name SelectCharacterDisplay


@export var gender: GlobalEnums.Gender: 
	set(value): 
		gender = value
		if gender == GlobalEnums.Gender.MALE: 
			sprites_switcher.current_tab = 0
			gender_label.text = "Male Character"
		else: 
			sprites_switcher.current_tab = 1
			gender_label.text = "Female Character"
		
@export var sprites_switcher: TabContainer
@export var gender_label: Label


func _on_on_control_tapped() -> void:
	pass # Replace with function body.
