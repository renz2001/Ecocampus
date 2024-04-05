extends Node

@export var state_chart: StateChart
@export var to_map_picker: ChangeSceneComponent
@export var playing_state: AtomicState
@export var paused_state: AtomicState

@export var menu_music: AudioManagerPlayer
@export var playing_music: AudioManagerPlayer
@export var assesment_music: AudioManagerPlayer


func start() -> void: 
	to_map_picker.change()


func is_playing() -> bool: 
	return playing_state.active


func is_paused() -> bool: 
	return paused_state.active


func _on_playing_state_entered() -> void:
	playing_music.play()


func _on_main_menu_state_entered() -> void:
	menu_music.play()


func _on_assesment_state_entered() -> void:
	assesment_music.play()
