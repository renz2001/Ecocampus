@tool
extends DialogGUI
class_name InteractDialog

@export var body: Control
@export var description_label: FormattedLabel
@export var ok_button: TextureButtonPlus

var data: InteractDialogData

static func display(args: InteractDialogData) -> InteractDialog: 
	var gui: InteractDialog = GUICollection.interact_dialogue.instantiate()
	#print(_caller)
	gui.data = args
	gui.global_position = gui.data.gui_position
	
	if gui.global_position.x < GlobalVariables.viewport_size.x / 2: 
		gui.body.pivot_offset = gui.body.size / 2
		gui.body.position.x *= -1
	
	if gui.data.description: 
		gui.data.description.set_label(gui.description_label)
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
	if GameManager.is_playing(): 
		data.caller.state_chart.send_event("enabled")


