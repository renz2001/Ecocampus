@tool
extends GUI
class_name CrossPlatformGUI


@export var current_platform_type: PlatformManager.PlatformType: 
	set(value): 
		current_platform_type = value
		if is_instance_valid(mode): 
			if current_platform_type == 0:
				return
			mode.current_tab = (current_platform_type - 1)

@export var mode: TabContainer
@export var pc: GUI
@export var mobile: GUI
@export var console: GUI


func _ready() -> void: 
	# This is executed if the GUI was not initiated with the GUIManager
	if !PlatformManager.platform_changed.is_connected(_on_platform_changed): 
		platform_init()
		appropriate_gui(PlatformManager.current_platform_type)


func platform_init() -> void: 
	PlatformManager.platform_changed.connect(_on_platform_changed)


func _on_platform_changed(new_platform: PlatformManager.PlatformType, _previous_platform: PlatformManager.PlatformType) -> void: 
	appropriate_gui(new_platform)


func get_gui(_alias: String) -> Control: 
	for node: GUI in get_node("Mode/%s" % [PlatformManager.current_platform_type_string]).get_children(): 
		if node.alias == _alias: 
			return node
	return null


func appropriate_gui(new_platform: PlatformManager.PlatformType) -> void: 
	current_platform_type = new_platform
	
	
