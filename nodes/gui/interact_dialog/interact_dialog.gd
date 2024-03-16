@tool
extends DialogGUI
class_name InteractDialog

@export var description_label: Label

var data: InteractDialogData

static func display(args: InteractDialogData) -> InteractDialog: 
	var gui: InteractDialog = GUICollection.interact_dialogue.instantiate()
	#print(_caller)
	gui.data = args
	gui.global_position = gui.data.gui_position
	gui.description_label.text = gui.data.description
	gui.data.caller.path_find.finished_navigation.connect(
		func(): 
			gui.data.caller.state_chart.send_event("cannot_tap")
			GUIManager.add_gui(gui)
	, CONNECT_ONE_SHOT
	)
	return gui


func _on_medium_wooden_button_pressed() -> void:
	data.on_button_pressed.call()
	_close()


func _deactivated() -> void: 
	_close()


func _close() -> void: 
	queue_free()
	data.caller.state_chart.send_event("can_tap")


