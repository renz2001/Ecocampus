extends OnPressedComponent


@export var target: Node
@export var set_active: bool

func _on_pressed() -> void: 
	if target is GUI: 
		GUIManager.set_gui_active(target, set_active)
	else: 
		target.visible = set_active
	
	
