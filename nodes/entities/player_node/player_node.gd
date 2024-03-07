extends EntityNode
class_name PlayerNode




func _on_point_and_click_controller_tapped(mouse_position: Vector2) -> void:
	state_chart.send_event("walk")




func _on_path_find_movement_component_move_finished() -> void:
	state_chart.send_event("idle")

