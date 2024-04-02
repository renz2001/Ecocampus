extends Node2D


func _ready() -> void:
	GameManager.state_chart.send_event("playing")


