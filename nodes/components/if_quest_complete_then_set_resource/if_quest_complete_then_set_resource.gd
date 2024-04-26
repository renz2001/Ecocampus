extends ConditionalSetResourcePropertyComponent
class_name IfQuestCompleteThenSetResource

@export var check_quest: Quest

var quest_complete: bool


func _ready() -> void: 
	WorldEventManager.event_called.connect(_on_event_called)
	
	
func _on_event_called(event: String, _called_by: Node, _args: Array):
	if !event == "ready": 
		return
	if ExtendedQuestSystem.is_quest_completed(check_quest): 
		update_condition()
		return
	ExtendedQuestSystem.quest_completed.connect(_on_quest_complete)
	
	
func _on_quest_complete(quest: Quest) -> void: 
	if check_quest.id == quest.id:  
		quest_complete = true
	update_condition()
	
	
func _condition() -> bool: 
	if quest_complete: 
		return true
	return false
	
