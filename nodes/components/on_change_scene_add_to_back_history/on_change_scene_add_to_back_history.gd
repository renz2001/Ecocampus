extends NodeComponent
class_name OnChangeSceneAddToBackHistory


@export var change_scene: ChangeSceneComponent


func _ready() -> void: 
	if !change_scene.is_node_ready(): 
		await change_scene.ready
		
	change_scene.changing.connect(_on_changing_scene)
	
	
func _on_changing_scene() -> void: 
	BackManager.add(get_tree().current_scene.scene_file_path)
	
	
