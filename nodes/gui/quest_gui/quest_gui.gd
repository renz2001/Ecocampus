@tool
extends PanelContainer
class_name QuestGUI


@export var quest: EcoQuest:
	set(value): 
		quest = value
		if !is_node_ready(): 
			await ready
		percentage_label.string_formatter = quest.percentage_description_format
		#var percentage: Percentage = Percentage.new()
		percentage_label.input([quest.percentage_description, quest.completed_percentage.to_string(), "100%"])
		
		for child: FormattedLabel in tasks.get_children(): 
			child.queue_free()
			
		for task: EcoQuestTask in quest.tasks: 
			#var label: FormattedLabel = FormattedLabel.create(tasks, "%s", [task.description]) 
			var label: FormattedLabel = formatted_label_scene.instantiate()
			tasks.add_child(label)
			label.string_formatter = StringFormatter.new()
			label.string_formatter.format = "- %s"
			label.label_settings = LabelSettings.new()
			label.label_settings.font_size = 40
			label.input([task.description])
			
			
@export var percentage_label: FormattedLabel

@export var tasks: VBoxContainer 

@export var formatted_label_scene: PackedScene

