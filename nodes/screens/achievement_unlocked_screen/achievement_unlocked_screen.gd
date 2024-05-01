@tool
extends GUI
class_name AchievementUnlockedScreen

@export var achievement: Achievement: 
	set(value): 
		achievement = value
		update()
		
@export var achievement_unlocked_gui: AchievementsUnlockedGUI

static func this() -> AchievementUnlockedScreen: 
	return GameManager.get_tree().get_first_node_in_group("AchievementUnlockedScreen")


static func display(_achievement: Achievement) -> AchievementUnlockedScreen: 
	var gui: AchievementUnlockedScreen = GUIManager.achievement_unlocked_screen
	GUIManager.set_gui_active(gui, true)
	gui.achievement = _achievement
	return gui


static func conceal() -> AchievementUnlockedScreen: 
	var gui: AchievementUnlockedScreen = GUIManager.achievement_unlocked_screen
	GUIManager.set_gui_active(gui, false)
	return gui
	
	
func update() -> void: 
	if !is_node_ready(): 
		await ready
	achievement_unlocked_gui.achievement = achievement
	
	
