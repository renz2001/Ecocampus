@tool
extends GUI
class_name AchievementUnlockedScreen

@export var tap_cooldown: Timer
@export var on_tap_set_active: OnTapSetActive
@export var achievement: Achievement: 
	set(value): 
		achievement = value
		update()
		
@export var achievement_unlocked_gui: AchievementUnlockedGUI

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
	#printerr(achievement_unlocked_gui.achievement)
	
	
func _activated() -> void: 
	super._activated()
	on_tap_set_active.visible = false
	tap_cooldown.timeout.connect(
		func(): 
			on_tap_set_active.visible = true
	)
	tap_cooldown.start()
