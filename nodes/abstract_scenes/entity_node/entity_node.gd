extends CharacterBody2D
class_name EntityNode

@export var state_chart: StateChart
@export var path_find: PathFindMovementComponent
@export var walk: MovementComponent
@export var hitbox: Hitbox

@export var display_interact_dialog: bool = true
@export var inventory: Inventory

@export var entity_name: String
@export var interact_description: String


## Virtual Function
func _interact() -> void: 
	pass


func _on_button_pressed() -> void: 
	#get_tree().get_first_node_in_group("Player"), get_global_mouse_position(), _interact
	if display_interact_dialog: 
		show_interact_dialog(interact_description)
	else: 
		_interact()


func show_interact_dialog(description: String) -> void: 
	InteractDialog.display(
		InteractDialogData.new()\
			.set_caller(
				GroupNodeFetcher.get_first_node(GroupNodeFetcher.player)
			)\
			.set_gui_position(get_global_mouse_position())\
			.set_on_button_pressed(_interact)\
			.set_description(description)
	)
