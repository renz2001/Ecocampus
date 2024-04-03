extends GUI
class_name QuestsMenu

@export var quests_container: QuestsContainer

func _ready() -> void: 
	QuestSystem.new_available_quest.connect(_on_new_available_quest)
	update()


func _on_new_available_quest(_quest: Quest) -> void: 
	update()
	
	
func update() -> void: 
	quests_container.quests = QuestSystem.active.quests

