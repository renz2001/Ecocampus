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
			ExtendedQuestSystem.start_quest(quest)
		Type.MARK_AS_AVAILABLE: 
			ExtendedQuestSystem.mark_quest_as_available(quest)
		Type.COMPLETE: 
			ExtendedQuestSystem.complete_quest(quest)
	
	
