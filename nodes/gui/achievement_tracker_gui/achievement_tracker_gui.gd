extends GUI
class_name AchievementTrackerGUI

@export var label: Label

func _ready() -> void: 
	update()
	GlobalData.achievements_tracker.medals.points.current_changed.connect(_on_medals_current_changed)


func _on_medals_current_changed(_new: float, _prev: float) -> void: 
	update()
	
	
func update() -> void: 
	label.text = str(GlobalData.achievements_tracker.medals.points.current)
	
	
