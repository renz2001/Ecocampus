extends CharacterBody2D
class_name EntityNode

@export var state_chart: StateChart
@export var path_find: PathFindMovementComponent
@export var walk: MovementComponent
@export var hitbox: Hitbox

@export var display_interact_dialogue: bool
@export var inventory: Inventory


func _on_button_pressed() -> void: 
	if display_interact_dialogue: 
		InteractDialog.display(self, _interact)
	else: 
		_interact()


## Virtual Function
func _interact() -> void: 
	pass
