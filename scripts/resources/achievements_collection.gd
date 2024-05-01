extends Resource
class_name AchievementsCollection 

@export var achievement_node_scene: PackedScene
@export var collection: Array[Achievement]

func reset() -> void: 
	for achievement: Achievement in collection: 
		achievement.reset()
