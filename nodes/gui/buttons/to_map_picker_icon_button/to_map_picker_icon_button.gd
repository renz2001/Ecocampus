extends TextureButtonPlus
class_name ToMapPickerIconButton

@export var to_map_picker: ChangeSceneComponent


func _on_pressed() -> void:
	var config: AlertDialogConfig = AlertDialogConfig.new()
	config.description = "Open Map?"
	config.yes_func = func(): to_map_picker.change()
	AlertDialogBase.display(config)
