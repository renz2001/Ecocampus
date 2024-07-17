@tool
extends GUI
class_name AchievementUnlockedGUI

@export var achievement: Achievement: 
	set(value): 
		achievement = value
		update()

@export var title_label: Label
@export var task_description_label: Label
@export var youve_earned_label: FormattedLabel


static func this() -> AchievementUnlockedGUI: 
	return GameManager.get_tree().get_first_node_in_group("AchievementUnlockedGUI")


func update() -> void: 
	if !is_node_ready(): 
		await ready
	if achievement == null: 
		return
	title_label.text = achievement.title
	task_description_label.text = achievement.task_description
	youve_earned_label.input([str(achievement.reward_medals)])
