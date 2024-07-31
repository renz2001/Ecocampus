@tool
extends InteractableEntityNode
class_name LadderPlacementArea 

@export var items_accesible_when_climbed: Array[PickuppableEntity]
@export var ground_marker: Marker2D
@export var top_marker: Marker2D

var on_ladder: bool
var has_ladder: bool: 
	set(value): 
		has_ladder = value
		if !is_node_ready(): 
			await ready
		if value: 
			default_entity_sprite.show()
			tap_hit_box.show()
			disabled = false
			is_item_accepted = true
		else: 
			default_entity_sprite.hide()
			tap_hit_box.hide()
			disable_items(true)
			disabled = true
			
			
func _ready() -> void: 
	if Engine.is_editor_hint():
		return
	has_ladder = false
	#set_physics_process(false)

func _on_item_accepted(_item_stack: ItemStack) -> void:
	#default_entity_sprite.show()
	#tap_hit_box.show()
	#disabled = false
	#is_item_accepted = true
	#disable_items(false)
	has_ladder = true


func _interact() -> void: 
	if !is_item_accepted: 
		return
		
	#PlayerManager.player.path_find_movement_component.finished_navigation.connect(
		#func(): 
			#move_to(top_marker)
	#, CONNECT_ONE_SHOT
	#)
	#move_to(ground_marker)
	if on_ladder: 
		move_down()
	else: 
		move_up()
	
	
func move_up() -> void: 
	var tween: Tween = get_tree().create_tween()
	var player: PlayerNode = PlayerManager.player
	var duration: float = 0.9
	
	GetMousePositionArea.this().visible = false
	
	tween.tween_property(player, "global_position", ground_marker.global_position,  duration)
	tween.chain()
	tween.step_finished.connect(
		func(idx: int): 
			player.lock_size = true
			player.z_index = 1
	, CONNECT_ONE_SHOT
	)
	tween.tween_property(player, "global_position", top_marker.global_position,  0.7)
	tween.finished.connect(
		func(): 
			player.animation_player.play("idle_left")
			disable_items(false)
			player_is_move_to_position = false
			player.is_move_to_position = false
			wait_for_player_to_display_interact_dialog = false
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
			player.z_index = 0
			GetMousePositionArea.this().visible = true
			#player_is_move_to_position = false
			#player.is_move_to_position = false
			player_is_move_to_position = true
			player.is_move_to_position = false
			wait_for_player_to_display_interact_dialog = true
	, CONNECT_ONE_SHOT
	)
	tween.play()
	player.animation_player.play("walk_right")
	on_ladder = false
	
	
func disable_items(value: bool) -> void: 
	for ent: PickuppableEntity in items_accesible_when_climbed: 
		if is_instance_valid(ent): 
			ent.disabled = value
		
	
func move_to(target: Node2D) -> void: 
	await get_tree().physics_frame
	PlayerManager.player.path_find_movement_component.target = target
	#printerr(PlayerManager.player.path_find_movement_component.target)
	await get_tree().physics_frame
	set_physics_process(true)
	
	
#func _physics_process(_delta: float) -> void: 
	#if Engine.is_editor_hint(): 
		#return
	#var result: bool = PlayerManager.player.path_find_movement_component.move()
	#if result == false: 
		#set_physics_process(false)
	
	
