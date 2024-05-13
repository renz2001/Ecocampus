extends OnVisibleDo
class_name OnVisibleAddToBackHistory

@export var add_current_scene: bool

func _on_visible() -> void: 
	#if Input.is_action_pressed("back"): 
		#return
	#await get_tree().process_frame
	#printerr(Input.is_action_pressed("back"))
	if get_tree().current_scene is MainMenu: 
		return
		
	if add_current_scene: 
		BackManager.add(owner.scene_file_path)
		return
	BackManager.add(node)


