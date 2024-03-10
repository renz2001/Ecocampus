extends CanvasLayer
class_name BaseGUIManager

signal gui_changed(gui: GUI)
signal gui_added(gui: GUI)
signal gui_removed(gui: GUI)

@export var alert: PackedScene 
@export var centered_acting_container: PackedScene
@export var exclusive_gui: PackedScene

@export var playing: Control
@export var instanced_uis: Control
@export var dropdown_popup: DropdownPopup
#@export var transitions_manager: TransitionsManager
#@export var player_hud: CrossPlatformGUI
#@export var pause_menu: GUI
#@export var dialogue_gui_manager: DialogueGUIManager
#@export var overlays_manager: OverlaysManager

#@export var touch_screen_controls: GUI
@export var _print_color: PrintColor

# _ready doesn't exist in CanvasLayer lol
#func _ready() -> void: 
	#super._ready()
	#RoomManager.room_is_ready.connect(init)


#func get_appropriate_gui(gui: CrossPlatformGUI, alias: String) -> GUI: 
	#return gui.get_appropriate_gui(alias)


#func init(_room: RoomNode) -> void:
	#gui_debugger.init(self)
	
	
func toggle_gui(gui: GUI) -> void:
	set_gui_active(gui, !gui.visible)
	
	
func set_gui_active(gui: GUI, active: bool) -> void: 
	#if active:
		#if !_can_be_activated(gui): 
			#return
	#if gui.name == "TransitionsManager": 
		#printerr(gui._initialized)
	_print_color.out_debug_wvalue("%s is set active" % gui.name, active)
	#if gui is DialogueGUIManager: 
		#print("")
	if gui.acting_container: 
		gui.acting_container.set_active(active)
	else:
		gui.set_active(active)
	
	
func add_gui(gui: GUI, config: AddGUIConfig = null) -> void:
	#if gui.get_parent() == instanced_uis:
		#return
	if config: 
		if !config.centered: 
			instanced_uis.add_child(gui)
		elif config && config.centered: 
			var acting_container: CenteredActingContainer = centered_acting_container.instantiate()
			instanced_uis.add_child(acting_container)
			acting_container.add_gui(gui)
		gui.position = config.position
		if config.is_exclusive: 
			var exclusive: GUI = exclusive_gui.instantiate()
			gui.add_child(exclusive)
			gui.move_child(exclusive, 0) 
			
	gui_added.emit(gui)
	gui_changed.emit(gui)
	
	
func set_and_add_gui(gui: GUI, active: bool, config: AddGUIConfig = null) -> void: 
	add_gui(gui, config)
	set_gui_active(gui, active)
	
	
func remove_gui(gui: GUI) -> void:
	set_gui_active(gui, false)
	if gui.acting_container: 
		gui.acting_container.queue_free()
	else: 
		gui.queue_free()
	gui_removed.emit(gui)
	gui_changed.emit(gui)


func create_alert(alert_message: String, yes_func: Callable = func(): , 
	no_func: Callable = func(): , yes_text: String = "Yes", 
	no_text: String = "No") -> AlertScreen: 
	var alert_node: AlertScreen = alert.instantiate()
	var yes_button: Button = alert_node.yes
	var no_button: Button = alert_node.no
	GUIManager.add_gui(alert_node, AddGUIConfig.new().set_centered(true).set_is_exclusive(true))
	alert_node.alert_label.text = alert_message
	yes_button.text = yes_text
	no_button.text = no_text
	yes_button.pressed.connect(yes_func)
	no_button.pressed.connect(no_func)
	return alert_node


func call_dropdown_popup(items: Array[DropdownPopupItem]) -> void: 
	dropdown_popup.activate(get_viewport().get_mouse_position(), items)

