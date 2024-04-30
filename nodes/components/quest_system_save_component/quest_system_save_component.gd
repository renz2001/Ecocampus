extends MasterSaveComponent
class_name QuestSystemSaveComponent

@export var quests_collection: QuestsCollection

func to_dict() -> Dictionary: 
	var serialized_quests: Array = [
		ExtendedQuestSystem.serialize_quests("Active"), 
		ExtendedQuestSystem.serialize_quests("Available"), 
		ExtendedQuestSystem.serialize_quests("Completed")
	]
	
	var dict: Dictionary = {
		str(get_path()): {
			"quests": ExtendedQuestSystem.quests_as_dict(), 
			"serialized_quests": serialized_quests
		}
	}
	return dict
	
	
func load_dict(dict: Dictionary) -> void: 
	var serialized_quests: Array = dict["serialized_quests"]
	#var quests: Array[Q4uest] = []
	#
	#for serialized_quest: Dictionary in serialized_quests: 
		#for dict_quest
		#for quest: Quest in quests_collection.collection: 
			#if quest.id == serialized_quest: 
				#pass
	for quest: Quest in quests_collection.collection: 
		for serialized_quest: Dictionary in serialized_quests: 
			for quest_id: String in serialized_quest.keys(): 
				if int(quest_id) == quest.id: 
					PropertiesToSave.load_dict_to_object(quest, serialized_quest[quest_id])
					quest.start()
	# --The reason why this error happens is because JSON.stringify converts the int to float.  --
	# E 0:00:03:0961   quest_manager.gd:204 @ dict_to_quests(): Condition "!_p->typed.validate(validated_array.write[i], "append_array")" is true.
		#<C++ Source>   core/variant/array.cpp:278 @ append_array()
		#<Stack Trace>  quest_manager.gd:204 @ dict_to_quests()
					 #quest_system_save_component.gd:42 @ load_dict()
					 #game_save.gd:39 @ load_game()
					 #save_manager.gd:92 @ load_current_game_save()
	
	# Converting an untyped array (Variant.Type.NULL) to a typed array. 
	var quests: Dictionary = dict["quests"]
	for key: String in quests.keys(): 
		var ids: Array[int] = []
		ids.assign(quests[key])
		quests[key] = ids
	
	ExtendedQuestSystem.dict_to_quests(quests, quests_collection.collection)
	
	QuestsMenu.this().update()
	#printerr("\nquests: ", ExtendedQuestSystem.get_active_quests())
