@tool
extends GUI
class_name ItemObtainedScreen

# TODO
@export var item_obtained_gui: ItemObtainedGUI
@export var item: ItemModel: 
	set(value): 
		item = value
		if !is_node_ready(): 
			await ready
		item_obtained_gui.item = item
		

static func this() -> AchievementUnlockedScreen: 
	return GameManager.get_tree().get_first_node_in_group("ItemObtainedScreen")


static func display(_item: ItemModel) -> ItemObtainedScreen: 
	var gui: ItemObtainedScreen = GUIManager.item_obtained_screen
	GUIManager.set_gui_active(gui, true)
	gui.item = _item
	return gui


static func conceal() -> ItemObtainedScreen: 
	var gui: ItemObtainedScreen = GUIManager.item_obtained_screen
	GUIManager.set_gui_active(gui, false)
	return gui
	
	
func update() -> void: 
	if !is_node_ready(): 
		await ready
	#achievement_unlocked_gui.achievement = achievement
	#printerr(achievement_unlocked_gui.achievement)
	
	
#func _activated() -> void: 
	#super._activated()
	#on_tap_set_active.visible = false
	#tap_cooldown.timeout.connect(
		#func(): 
			#on_tap_set_active.visible = true
	#)
	#tap_cooldown.start()
