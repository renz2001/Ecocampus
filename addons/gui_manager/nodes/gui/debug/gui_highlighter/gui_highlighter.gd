extends Control
class_name GUIHighlighter

@export var enabled: bool
@export var gui_name_label: Label
@export var gui_highlighter: ColorRect


func init(ui_manager: Object) -> void: 
	if enabled: 
		connect_children_mouse_signals(ui_manager)
		
		
func connect_children_mouse_signals(parent: Object) -> void:
	var children: Array[Node] = parent.get_children()
	for child in children:
#		print("\nchildren: ", children, "\n || key: ", key)
#		print(" || data: ", child)
		if child is Control:
			child.mouse_entered.connect(func(): highlight_gui(true, child))
			child.mouse_exited.connect(func(): highlight_gui(false, child))
			child.hidden.connect(func(): highlight_gui(false) )
		if child.get_child_count() > 0:
			connect_children_mouse_signals(child)
			

func highlight_gui(active: bool, gui_hovered: Control = null) -> void: 
	if enabled == false:
		return
	gui_highlighter.visible = active 
	if gui_hovered == null: 
		return
	gui_highlighter.size = gui_hovered.size
	gui_highlighter.global_position = gui_hovered.global_position
	label_gui(gui_hovered, active)
	
	
func label_gui(gui_hovered: Control, active: bool) -> void: 
	var gui_name: String = gui_hovered.name 
	gui_name_label.visible = active
	gui_name_label.text = gui_name
