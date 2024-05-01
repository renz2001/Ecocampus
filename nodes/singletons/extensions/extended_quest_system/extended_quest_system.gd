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


func dict_to_quests(dict: Dictionary, quests: Array[Quest]) -> void:
	for pool: BaseQuestPool in get_children():

		# Make sure to iterate only for available pools
		if !dict.has(pool.name.to_lower()): continue

		# Match quest with their ids and insert them into the quest pool
		var quest_with_id: Dictionary = {}
		var pool_ids: Array[int] = []
		#printerr((dict[pool.name.to_lower()] as Array[int]).get_typed_builtin())
		var dict_pool: Array[int] = dict[pool.name.to_lower()] as Array[int]
		
		pool_ids.append_array(dict_pool)
		#
		#for id: int in dict_pool: 
			#if id in pool_ids
		# FIXME:  PREVENT DUPLICATION
		#print(pool_ids.get_typed_builtin())
		for quest in quests: 
			if quest.id in pool_ids: 
				if !pool.is_quest_inside(quest):
					pool.add_quest(quest)
				quests.erase(quest)


func reset_all() -> void: 
	completed.reset()
	active.reset()
	available.reset()
	
	
	
	
