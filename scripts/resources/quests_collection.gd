extends Resource
class_name QuestsCollection

@export var collection: Array[Quest]


func start_quests() -> void: 
	for quest: Quest in collection: 
		ExtendedQuestSystem.start_quest(quest)


