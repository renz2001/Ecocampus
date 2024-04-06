extends Node



@export var state_chart: StateChart
@export var to_map_picker: ChangeSceneComponent
@export var playing_state: AtomicState
@export var paused_state: AtomicState
@export var main_menu_state: AtomicState

@export var menu_music: AudioManagerPlayer
@export var playing_music: AudioManagerPlayer
@export var assesment_music: AudioManagerPlayer
@export var print_color: PrintColor: 
	set(value): 
		print_color = value
		print_color.owner = self

func start() -> void: 
	to_map_picker.change()


func is_playing() -> bool: 
	return playing_state.active


func is_paused() -> bool: 
	return paused_state.active


func _on_playing_state_entered() -> void:
	playing_music.play()
	PlayerManager.player.state_chart.send_event("enabled")


func _on_main_menu_state_entered() -> void:
	menu_music.play()


func _on_playing_state_exited() -> void: 
	if PlayerManager.player: 
		PlayerManager.player.state_chart.send_event("disabled")


func _on_state_chart_event_received(event: StringName) -> void:
	print_color.out_debug_wvalue("State chart event received", event)
