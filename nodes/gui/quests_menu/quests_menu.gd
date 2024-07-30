extends GUI
class_name QuestsMenu

@export var panel_container: PanelContainer
@export var quests_container: QuestsContainer

var quests: Array[Quest]: 
	get: 
		return ExtendedQuestSystem.active.quests as Array[Quest]


static func this() -> QuestsMenu: 
	return GameManager.get_tree().get_first_node_in_group("QuestsMenu")


func _ready() -> void: 
	update()
	ExtendedQuestSystem.quest_accepted.connect(_on_quest_accepted)
	ExtendedQuestSystem.quest_completed.connect(_on_quest_completed)
	for quest: EcoQuest in ExtendedQuestSystem.active.quests: 
		quest.task_completed.connect(_on_task_completed)
	
	
func _on_task_completed() -> void: 
	update()
	

func _on_quest_accepted(_quest: Quest) -> void: 
	update()
	
	
func _on_quest_completed(_quest: Quest) -> void: 
	update()
	
	
func update() -> void: 
	quests_container.quests = quests
	if quests_container.quests: 
		panel_container.size.y = 512
	else: 
		panel_container.size.y = 93
		
	quests_container.update()
	
	
func _activated() -> void: 
	super._activated()
	quests_container.update()
	
	
func _process(_delta: float) -> void: 
	#print(ExtendedQuestSystem.active.quests)
	pass
