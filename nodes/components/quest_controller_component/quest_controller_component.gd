extends NodeComponent
class_name QuestControllerComponent


enum Type {
	START, 
	MARK_AS_AVAILABLE, 
	COMPLETE
}

@export var type: Type
@export var quest: Quest


func use() -> void: 
	match type: 
		Type.START: 
			ExtendedQuestSystem.mark_quest_as_available(quest)
			ExtendedQuestSystem.start_quest(quest)
			await get_tree().create_timer(0.8)
			var menu: QuestsMenu = GroupNodeFetcher.get_first_node("QuestsMenu")
			GUIManager.toggle_gui(menu)
		Type.MARK_AS_AVAILABLE: 
			ExtendedQuestSystem.mark_quest_as_available(quest)
		Type.COMPLETE: 
			ExtendedQuestSystem.complete_quest(quest)
	
	
