extends Node
class_name AchievementsTracker

# Hard coding this cuz why not

#@export var achievements_collection: AchievementsCollection: 
	#set(value): 
		#achievements_collection = value
		#if !is_node_ready(): 
			#await ready
		#for child: Node in get_achievements(): 
			#child.queue_free()
			#
		#for achievement: Achievement in achievements_collection.collection: 
			#var node: AchievementNode = achievements_collection.achievement_node_scene.instantiate()
			#achievements.add_child(node)
			#node.achievement = achievement
			
@export var achievements_quests: Array[EcoQuest]

var medals: PointCounterComponent


func _ready() -> void: 
	for quest: EcoQuest in achievements_quests: 
		ExtendedQuestSystem.start_quest(quest)
		
	ExtendedQuestSystem.quest_completed.connect(_on_quest_completed)
	
	
func _on_quest_completed(quest: Quest) -> void: 
	var eco_quest: EcoQuest = quest
	#(quest as EcoQuest).display_achievement() 
	medals.add(eco_quest.on_complete_unlock_achievement.reward_medals)
	pass
	
	
	
