extends Button
class_name GetMousePositionArea

signal tapped


static func this() -> GetMousePositionArea: 
	return GameManager.get_tree().get_first_node_in_group("GetMousePositionArea")


func _on_pressed() -> void:
	tapped.emit()
