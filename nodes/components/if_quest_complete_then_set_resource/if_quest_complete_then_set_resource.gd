extends ConditionalSetResourcePropertyComponent
class_name IfQuestCompleteThenSetResource

@export var check_quest: Quest
@export var print_color: PrintColor: 
	set(value): 
		print_color = value
		print_color.owner = self

var quest_complete: bool


func _ready() -> void: 
	update_condition()
	WorldEventManager.event_called.connect(_on_event_called)
	
	
func _on_event_called(event: String, _called_by: Node, _args: Array):
	if event != "ready": 
		return
	update_condition()
	if quest_complete: 
		return 
	ExtendedQuestSystem.quest_completed.connect(_on_quest_complete)
	
	
func _on_quest_complete(_quest: Quest) -> void: 
	update_condition()
	
	
func _condition() -> bool: 
	quest_complete = ExtendedQuestSystem.is_quest_completed(check_quest)
	#printerr(ExtendedQuestSystem.completed.quests)
	#printerr("check quest: ", check_quest)
	#printerr("quest completed: ", ExtendedQuestSystem.is_quest_completed(check_quest))
	#printerr("quest completed cool: ", check_quest in ExtendedQuestSystem.completed.quests)
	return quest_complete
	
	
func _condition_met() -> void: 
	super._condition_met()
	print_color.out_debug_wvalue("Completed quest: %s, replacing this" % check_quest, node)
