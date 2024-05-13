extends OnPressedComponent
class_name OnPressedNextDialogue

@export var do_not_skip_when_typing: bool

func _on_pressed() -> void: 
	if do_not_skip_when_typing && GUIManager.dialogue_gui_manager.current_dialogue_gui.dialogue_label.is_typing:
		return
	GUIManager.dialogue_gui_manager.next()
