extends "res://addons/quest_system/quest_manager.gd"



func serialize_quests(pool: String) -> Dictionary:
	var pool_node: BaseQuestPool = get_node_or_null(pool)

	if pool_node == null: return {}

	var quest_dictionary: Dictionary = {}
	
	for quest: Quest in pool_node.quests:
		var save: PropertiesToSave = PropertiesToSave.new()
		save.properties = [
			"id", 
			"tasks", 
			"objective_completed", 
		]
		
		var quest_data: Dictionary = save.to_dict(quest)
		quest_dictionary[quest.id] = quest_data

	return quest_dictionary
