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
@export var interact_description: BaseLabelText
@export var dialogue: DialogueArguments: 
	set(value): 
		dialogue = value
		if !is_node_ready(): 
			await ready
		dialogue_starter.dialogue = dialogue
@export var quiz: Quiz
@export var quest: EcoQuest
@export var disable_after_interact: bool
@export var disabled: bool

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
@export var master_save_component: MasterSaveComponent

func _ready() -> void: 
	pass
	
	
func set_data(value: Entity) -> void: 
	data = value


func interact() -> void: 
	_on_interact()


## Virtual Function
func _interact() -> void: 
	pass


func _on_interact() -> void: 
	if disabled: 
		return
	_interact()
	if interact_audio: 
		interact_audio_player.play()
	if dialogue == null: 
		if quiz != null: 
			QuizAttemptScreen.display(quiz, data)
	dialogue_starter.start()
	call_world_event_component.play()
	interacted.emit()
	if disable_after_interact: 
		disabled = true


func show_interact_dialog(description: BaseLabelText) -> void: 
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
	if !PlayerManager.player: 
		return
	if display_interact_dialog: 
		if wait_for_player_to_display_interact_dialog: 
			if !PlayerManager.player.path_find.changed_target.is_connected(_on_changed_target): 
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
	match value: 
		"start_quiz": 
			QuizAttemptScreen.display(quiz, data)
		"start_quest": 
			ExtendedQuestSystem.start_quest(quest)
		"remove_dialogue": 
			dialogue = null


func _on_ready_unique_resource_resource_ready() -> void:
	if inventory: 
		inventory.owner = self

