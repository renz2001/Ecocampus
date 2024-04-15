extends CharacterBody2D
class_name EntityNode

signal interacted

@export var display_interact_dialog: bool = true
@export var wait_for_player_to_display_interact_dialog: bool = true

@export var interact_audio: AudioStreamPlayerArguments: 
	set(value): 
		interact_audio = value
		if !is_node_ready(): 
			await ready
		interact_audio_player.audio = interact_audio
		
@export var on_interact_call_world_event: WorldEventCall: 
	set(value): 
		on_interact_call_world_event = value
		if !is_node_ready(): 
			await ready
		call_world_event_component.event_call = on_interact_call_world_event

@export var inventory: Inventory: 
	set(value): 
		inventory = value
		if inventory: 
			inventory.owner = self

@export var data: Entity: set = set_data
@export var interact_description: LabelText
@export var dialogue: DialogueArguments: 
	set(value): 
		dialogue = value
		if !is_node_ready(): 
			await ready
		dialogue_starter.dialogue = dialogue
@export var quiz: Quiz

@export_group("Dependencies")
@export var state_chart: StateChart
@export var path_find: PathFindMovementComponent
@export var walk: MovementComponent
@export var hitbox: Hitbox
@export var node_variety_manager: NodeVarietyManager
@export var interact_audio_player: AudioManagerPlayer
@export var interact_dialog_position: Marker2D
@export var dialogue_starter: DialogueStarter
@export var dialogue_response_handler: DialogueResponseHandler
@export var call_world_event_component: CallWorldEventComponent
@export var ready_unique_resource: ReadyUniqueResource



func _ready() -> void: 
	pass
		
		
func set_data(value: Entity) -> void: 
	data = value


## Virtual Function
func _interact() -> void: 
	pass


func _on_interact() -> void: 
	_interact()
	if interact_audio: 
		interact_audio_player.play()
	dialogue_starter.start()
	call_world_event_component.play()
	interacted.emit()


func show_interact_dialog(description: LabelText) -> void: 
	var dialog: InteractDialog = InteractDialog.display(
		InteractDialogData.new()\
			.set_caller(
				PlayerManager.player
			)\
			.set_gui_position(interact_dialog_position.global_position)\
			.set_on_button_pressed(_on_interact)\
			.set_description(description)
	)
	
	if interact_audio: 
		dialog.ok_button.button_audio_player.disabled = true


func _on_tap_hit_box_pressed() -> void:
	if display_interact_dialog: 
		if wait_for_player_to_display_interact_dialog: 
			PlayerManager.player.path_find.changed_target.connect(_on_changed_target, CONNECT_ONE_SHOT)
			PlayerManager.player.path_find.finished_navigation.connect(_on_finished_navigation, CONNECT_ONE_SHOT)
		else: 
			show_interact_dialog(interact_description)
	else: 
		_on_interact()


func _on_changed_target() -> void: 
	if PlayerManager.player.path_find.finished_navigation.is_connected(_on_finished_navigation): 
		PlayerManager.player.path_find.finished_navigation.disconnect(_on_finished_navigation)


func _on_finished_navigation() -> void: 
	show_interact_dialog(interact_description)


func _on_dialogue_response_handler_responded(value: String) -> void: 
	if value == "accept_quiz": 
		QuizAttemptScreen.display(quiz)


func _on_ready_unique_resource_resource_ready() -> void:
	if inventory: 
		inventory.owner = self

