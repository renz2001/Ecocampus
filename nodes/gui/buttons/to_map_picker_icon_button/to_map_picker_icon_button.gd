extends TextureButtonPlus
class_name ToMapPickerIconButton

@export var to_map_picker: ChangeSceneComponent


func _on_pressed() -> void:
	to_map_picker.change()
