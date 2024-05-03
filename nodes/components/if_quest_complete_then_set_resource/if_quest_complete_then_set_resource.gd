extends ConditionalSetResourcePropertyComponent
class_name IfQuestCompleteThenSetResource

@export var check_quest: Quest


var quest_complete: bool


func _ready() -> void: 
	update_condition()
	if quest_complete: 
		return 
	ExtendedQuestSystem.quest_completed.connect(_on_quest_complete)
	
	
func _on_quest_complete(_quest: Quest) -> void: 
	update_condition()
	
	
func _condition() -> bool: 
	quest_complete = ExtendedQuestSystem.is_quest_completed(check_quest)
	return quest_complete
	
	
func _condition_met() -> void: 
	super._condition_met()
	print_color.out_debug_wvalue("Completed quest: %s, replacing this" % check_quest, node)
