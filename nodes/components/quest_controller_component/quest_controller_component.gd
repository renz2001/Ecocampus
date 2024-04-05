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
			QuestSystem.start_quest(quest)
		Type.MARK_AS_AVAILABLE: 
			QuestSystem.mark_quest_as_available(quest)
		Type.COMPLETE: 
			QuestSystem.complete_quest(quest)
	
	
