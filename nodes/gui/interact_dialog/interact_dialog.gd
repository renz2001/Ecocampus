extends GUI
class_name InteractDialog

@export var information_label: Label

var on_button_pressed: Callable
var caller: Node


static func display(_caller: Node, _on_button_pressed: Callable) -> InteractDialog: 
	var gui: InteractDialog = GUICollection.interact_dialogue.instantiate()
	GUIManager.add_gui(gui)
	gui.on_button_pressed = _on_button_pressed
	gui.caller = _caller
	return gui


func _on_medium_wooden_button_pressed() -> void:
	on_button_pressed.call()


