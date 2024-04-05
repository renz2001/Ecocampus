extends CharacterBody2D
class_name EntityNode

signal interacted

@export var display_interact_dialog: bool = true
@export var inventory: Inventory: 
	set(value): 
		inventory = value
		if inventory: 
			inventory.owner = self

@export var data: Entity: set = set_data
@export var interact_description: String

@export_group("Dependencies")
@export var state_chart: StateChart
@export var path_find: PathFindMovementComponent
@export var walk: MovementComponent
@export var hitbox: Hitbox
@export var node_variety_manager: NodeVarietyManager


func _ready() -> void: 
	if inventory: 
		inventory.owner = self


func set_data(value: Entity) -> void: 
	data = value


## Virtual Function
func _interact() -> void: 
	pass


func _on_button_pressed() -> void: 
	#get_tree().get_first_node_in_group("Player"), get_global_mouse_position(), _interact
	if display_interact_dialog: 
		show_interact_dialog(interact_description)
	else: 
		_interact()
		interacted.emit()


func show_interact_dialog(description: String) -> void: 
	InteractDialog.display(
		InteractDialogData.new()\
			.set_caller(
				PlayerManager.player
			)\
			.set_gui_position(get_global_mouse_position())\
			.set_on_button_pressed(_interact)\
			.set_description(description)
	)

