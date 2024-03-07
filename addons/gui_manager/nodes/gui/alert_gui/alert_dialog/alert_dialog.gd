extends GUI
class_name AlertBox

@onready var alert_label: Label = %AlertLabel
@onready var no: Button = %No
@onready var yes: Button = %Yes

# This has to be added onto GUIManager

func _ready() -> void: 
	GUIManager.layer = 2
	no.call_deferred("grab_focus")


func _on_no_pressed() -> void:
	_done()


func _on_yes_pressed() -> void:
	_done()


func _done():
	GUIManager.layer = 1
	GUIManager.remove_gui(self)

