extends ConditionalSetResourcePropertyComponent
class_name IfQuestCompleteThenSetResource

@export var check_quest: Quest

var quest_complete: bool


func _ready() -> void: 
	update_condition()
	if quest_complete: 
		return 
	WorldEventManager.event_called.connect(_on_event_called)
	
	
func _on_event_called(event: String, _called_by: Node, _args: Array):
	if !event == "ready": 
		return
	ExtendedQuestSystem.quest_completed.connect(_on_quest_complete)
	
	
func _on_quest_complete(_quest: Quest) -> void: 
	update_condition()
	
	
func _condition() -> bool: 
	quest_complete = ExtendedQuestSystem.is_quest_completed(check_quest)
	return quest_complete
	
	
