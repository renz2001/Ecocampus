extends EntityNode
class_name PlayerNode

@export var move_to_tap: MoveToTapPathFindMovement
@export var mouse_position: MousePositionComponent


func _ready() -> void: 
	GlobalData.player_instanced.emit(self)
	

func _on_idle_state_entered() -> void:
	path_find.stop()
	
	
func _on_walk_state_entered() -> void: 
	move_to_tap.move()


func _on_walk_stopped() -> void:
	state_chart.send_event("idle")


func _on_can_tap_state_input(event: InputEvent) -> void:
	if event.is_action_pressed("tap"): 
		if mouse_position.get_position_direction_relative_to(global_position)[0] == BaseGlobalEnums.Directions.LEFT: 
			state_chart.send_event("left")
		else: 
			state_chart.send_event("right")
			
		state_chart.send_event("idle")
		state_chart.send_event("walk")
