@tool
extends DialogGUI
class_name InteractDialog

@export var description_label: Label
@export var ok_button: TextureButtonPlus

var data: InteractDialogData

static func display(args: InteractDialogData) -> InteractDialog: 
	var gui: InteractDialog = GUICollection.interact_dialogue.instantiate()
	#print(_caller)
	gui.data = args
	gui.global_position = gui.data.gui_position
	gui.description_label.text = gui.data.description
	GUIManager.add_gui(gui)
	gui.data.caller.state_chart.send_event("disabled")
	return gui


func _on_medium_wooden_button_pressed() -> void:
	data.on_button_pressed.call()
	_close()


func _deactivated() -> void: 
	_close()


func _close() -> void: 
	queue_free()
	data.caller.state_chart.send_event("enabled")


