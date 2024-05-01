extends SaveableResource
class_name Achievement

signal unlocked

@export var title: String
@export var task_description: String
@export var reward_medals: int = 1

var is_unlocked: bool: 
	set(value): 
		is_unlocked = value
		if is_unlocked: 
			unlocked.emit()
	
	
func unlock() -> void: 
	if is_unlocked: 
		return
	is_unlocked = true
	GlobalData.achievements_tracker.medals.points.add(reward_medals)
	GlobalData.achievements_tracker.update_victory()
	
	
func display() -> void: 
	AchievementUnlockedScreen.display(self)
	
	
func _save_properties() -> PackedStringArray: 
	return [
		"is_unlocked"
	]

func reset() -> void: 
	is_unlocked = false
	
	
