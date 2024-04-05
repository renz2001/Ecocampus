extends Node2D
class_name LevelNode

@export var test_quest: EcoQuest

func _ready() -> void:
	GameManager.state_chart.send_event("playing")
	QuestSystem.start_quest(test_quest)


