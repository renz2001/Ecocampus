extends ConditionalSetPropertyComponent
class_name IfCurrentSceneInBackHistory


func _condition() -> bool: 
	return get_tree().current_scene.scene_file_path in BackManager.history.data

