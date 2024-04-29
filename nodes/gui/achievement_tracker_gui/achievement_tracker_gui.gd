extends GUI
class_name AchievementTrackerGUI

@export var label: Label

func _ready() -> void: 
	update()
	GlobalData.achievements_tracker.medals.ready_unique_resource.resource_ready.connect(
		_on_readu_unique_resource
	, CONNECT_ONE_SHOT
	)
	
	#printerr(GlobalData.achievements_tracker.medals.points.current_changed.is_connected(_on_medals_current_changed))


func _on_readu_unique_resource() -> void: 
	GlobalData.achievements_tracker.medals.points.current_changed.connect(_on_medals_current_changed)


func _on_medals_current_changed(_new: float, _prev: float) -> void: 
	update()
	
	
func update() -> void: 
	label.text = str(GlobalData.achievements_tracker.medals.points.current)
	
	
