@tool
extends ActingContainer
class_name CenteredActingContainer

@export var center_container: CenterContainer


func add_gui(gui: GUI) -> void: 
	center_container.add_child(gui)
	gui.acting_container = self
