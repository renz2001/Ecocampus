extends CanvasLayer

@export var gui_highlighter: GUIHighlighter
@export var last_event_called_label: Label
@export var current_camera_focused_label: Label
@export var current_platform_label: Label
@export var current_game_state: Label

var current_camera_focused_label_text: String = "CurrentCameraFocused: %s" 
var current_platform_label_text: String = "CurrentPlatform: %s" 
var last_event_called_label_text: String = "LastEventCalled: %s, Called by: %s" 
var room_state_label_text: String = "RoomState: %s"
var current_game_state_text: String = "CurrentGameState: %s"


func _ready() -> void: 
	#GameManager.state_machine.changed_state.connect(
		#func(new: BaseState): 
			#current_game_state.text = current_game_state_text % new.name
	#)
	platform_init()
	RoomManager.room_is_ready.connect(room_init)
	
	
func platform_init() -> void: 
	PlatformManager.platform_changed.connect(
		func(_new_platform, _previous_platform): 
			current_platform_label.text = current_platform_label_text % PlatformManager.current_platform_type_string
	)
	
	
# Called from RoomNode's init()
func room_init(_room: RoomNode) -> void: 
	CameraManager.transitioned_to_new_camera.connect(
		func(new_camera: VirtualCamera): 
			current_camera_focused_label.text = current_camera_focused_label_text % new_camera.name
	)
	WorldEventManager.event_called.connect(
		func(event: WorldEvent, called_by: Node): 
			last_event_called_label.text = last_event_called_label_text % [event.name, called_by]
	)
	#RoomManager.state_machine.changed_state.connect(
		#func(state: BaseState): 
			#room_state_label.text = room_state_label_text % state.name
	#)
	

