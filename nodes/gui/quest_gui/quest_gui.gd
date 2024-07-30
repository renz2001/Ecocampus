@tool
extends PanelContainer
class_name QuestGUI


@export var quest: EcoQuest:
	set(value): 
		quest = value
		if !is_node_ready(): 
			await ready
			
		update()
		quest.task_completed.connect(
			func(_task: EcoQuestTask): 
				update()
		)
		
		quest_task_container.quest = quest
	
@export var percentage_label: FormattedLabel

@export var quest_task_container: QuestTaskContainer

func update() -> void: 
	percentage_label.string_formatter = quest.percentage_description_format
	percentage_label.input([quest.percentage_description, quest.completed_percentage.to_string(), "100%"])
	
	
