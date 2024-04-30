@tool
extends EntityNode
class_name PlayerNode

@export var gender: GlobalEnums.Gender: 
	set(value): 
		gender = value
		if !is_node_ready(): 
			await ready
		if gender == GlobalEnums.Gender.MALE: 
			node_variety_manager.index = 1
		else: 
			node_variety_manager.index = 0
		
@export_group("Dependencies")
@export var move_to_tap: MoveToTapPathFindMovement
@export var mouse_position: MousePositionComponent
@export var cosmetic_equipper_component: CosmeticEquipperComponent


func _ready() -> void: 
	super._ready()
	if Engine.is_editor_hint(): 
		return
	PlayerManager.player_instanced.emit()


func _on_idle_state_entered() -> void:
	path_find.stop()
	
	
func _on_walk_state_entered() -> void: 
	move_to_tap.move()


func _on_can_tap_state_input(event: InputEvent) -> void:
	#event.
	if event.is_action_pressed("tap"): 
		if mouse_position.get_position_direction_relative_to(global_position)[0] == BaseGlobalEnums.Directions.LEFT: 
			state_chart.send_event("left")
		else: 
			state_chart.send_event("right")
			
		# Idle event is sent first so that it resets. ???
		state_chart.send_event("idle")
		state_chart.send_event("walk")


func set_data(value: Entity) -> void: 
	data = value
	if data: 
		data.gender_changed.connect(_on_gender_changed)
		gender = data.gender


func _on_gender_changed() -> void: 
	gender = data.gender


func _on_path_find_movement_component_finished_navigation() -> void: 
	state_chart.send_event("idle")




