extends Node
class_name AchievementsTracker


@export var achievements: Node
@export var total_badges: PointCounterComponent
@export var current_badges: PointCounterComponent


func _on_global_data_player_instanced(player: PlayerNode) -> void:
	player.inventory.items_changed.connect(_on_player_inventory_items_changed)
	
	
func _on_player_inventory_items_changed(_previous_items: Array[Item], _new_items: Array[Item], _changed_by: Node) -> void: 
	#var player: PlayerNode = GroupNodeFetcher.get_player()
	pass
	
	
	
