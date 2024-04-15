extends GUI
class_name AchievementUnlockedScreen


static func display(achievement: Achievement) -> AchievementUnlockedScreen: 
	var gui: AchievementUnlockedScreen = GUIManager.achievement_unlocked_screen
	GUIManager.set_gui_active(gui, true)
	gui.achievement = achievement
	return gui


static func conceal() -> AchievementUnlockedScreen: 
	var gui: AchievementUnlockedScreen = GUIManager.achievement_unlocked_screen
	GUIManager.set_gui_active(gui, false)
	return gui
	
	
