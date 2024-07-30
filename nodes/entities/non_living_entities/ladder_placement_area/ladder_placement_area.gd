@tool
extends InteractableEntityNode
class_name LadderPlacementArea 

@export var items_accesible_when_climbed: Array[PickuppableEntity]
@export var ground_marker: Marker2D
@export var top_marker: Marker2D

var on_ladder: bool

func _ready() -> void: 
	if Engine.is_editor_hint():
		return
	default_entity_sprite.hide()
	tap_hit_box.hide()
	disable_items(true)
	set_physics_process(false)


func _on_item_accepted(_item_stack: ItemStack) -> void:
	default_entity_sprite.show()
	tap_hit_box.show()


func _interact() -> void: 
	for entity: PickuppableEntity in items_accesible_when_climbed: 
		entity.disabled = false
		
	#PlayerManager.player.path_find_movement_component.finished_navigation.connect(
		#func(): 
			#move_to(top_marker)
	#, CONNECT_ONE_SHOT
	#)
	#move_to(ground_marker)
	move_up()
	
	
func move_up() -> void: 
	var tween: Tween = get_tree().create_tween()
	var player: PlayerNode = PlayerManager.player
	var duration: float = 0.9
	
	tween.tween_property(player, "global_position", ground_marker.global_position,  duration)
	tween.chain()
	tween.step_finished.connect(
		func(idx: int): 
			player.lock_size = true
	, CONNECT_ONE_SHOT
	)
	tween.tween_property(player, "global_position", top_marker.global_position,  0.7)
	tween.finished.connect(
		func(): 
			player.animation_player.play("idle_left")
			disable_items(false)
	, CONNECT_ONE_SHOT
	)
	tween.play()
	player.animation_player.play("walk_left")
	on_ladder = true
	
	
func move_down() -> void: 
	var tween: Tween = get_tree().create_tween()
	var player: PlayerNode = PlayerManager.player
	var duration: float = 0.9
	
	tween.tween_property(player, "global_position", ground_marker.global_position,  duration)
	#tween.chain()
	#tween.tween_property(player, "global_position", top_marker.global_position,  duration)
	tween.finished.connect(
		func(): 
			player.animation_player.play("idle_right")
			player.lock_size = false
			disable_items(true)
	, CONNECT_ONE_SHOT
	)
	tween.play()
	player.animation_player.play("walk_right")
	on_ladder = false
	
	
func disable_items(value: bool) -> void: 
	for ent: PickuppableEntity in items_accesible_when_climbed: 
		ent.disabled = value
		
	
func move_to(target: Node2D) -> void: 
	await get_tree().physics_frame
	PlayerManager.player.path_find_movement_component.target = target
	#printerr(PlayerManager.player.path_find_movement_component.target)
	await get_tree().physics_frame
	set_physics_process(true)
	
	
func _physics_process(_delta: float) -> void: 
	if Engine.is_editor_hint(): 
		return
	var result: bool = PlayerManager.player.path_find_movement_component.move()
	if result == false: 
		set_physics_process(false)
	
	
