@tool
extends GUI
class_name AchievementsUnlockedGUI

@export var achievement: Achievement: 
	set(value): 
		achievement = value
		update()

@export var sprite_rect: TextureRect
@export var title_label: Label
@export var task_description_label: Label


func update() -> void: 
	if !is_node_ready(): 
		await ready
	if achievement == null: 
		return
	title_label.text = achievement.title
	task_description_label.text = "(%s)" % achievement.task_description
	
