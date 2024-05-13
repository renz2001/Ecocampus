extends TextureButtonPlus
class_name BackButton 


func _ready() -> void: 
	if BackManager.history.data.size() > 1: 
		show()
	else: 
		hide()
		

func _on_pressed() -> void:
	BackManager.back()

