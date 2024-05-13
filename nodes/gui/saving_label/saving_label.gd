extends GUI
class_name SavingLabel


func _ready() -> void: 
	SaveManager.saved_data_to_file.connect(
		_on_saved_data_to_file
	)
	
	
func _on_saved_data_to_file(_save: GameSave, _file: SaveFile) -> void: 
	show()
	await get_tree().create_timer(0.5).timeout
	hide()
	
