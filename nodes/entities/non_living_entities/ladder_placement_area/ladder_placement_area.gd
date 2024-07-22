@tool
extends InteractableEntityNode
class_name LadderPlacementArea 

@export var items_accesible_when_climbed: Array[PickuppableEntity]
@export var ground_marker: Marker2D
@export var top_marker: Marker2D


func _ready() -> void: 
	if Engine.is_editor_hint():
		return
	default_entity_sprite.hide()
	tap_hit_box.hide()
	set_physics_process(false)


func _on_item_accepted(item_stack: ItemStack) -> void:
	default_entity_sprite.show()
	tap_hit_box.show()


func _interact() -> void: 
	for entity: PickuppableEntity in items_accesible_when_climbed: 
		entity.disabled = false
		
	PlayerManager.player.path_find_movement_component.finished_navigation.connect(
		func(): 
			move_to(top_marker)
	, CONNECT_ONE_SHOT
	)
	move_to(ground_marker)
	
	
func move_to(target: Node2D) -> void: 
	await get_tree().physics_frame
	PlayerManager.player.path_find_movement_component.target = target
	printerr(PlayerManager.player.path_find_movement_component.target)
	await get_tree().physics_frame
	set_physics_process(true)
	
	
func _physics_process(delta: float) -> void: 
	if Engine.is_editor_hint(): 
		return
	var result: bool = PlayerManager.player.path_find_movement_component.move()
	if result == false: 
		set_physics_process(false)
	
	
