@tool
extends EntityNode
class_name PickuppableEntity

@export var need_quest_before_enabled: EcoQuest

func _ready() -> void: 
	super._ready() 
	interact_description = RichLabelText.new()
	
	interact_description.format = StringFormatter.new()
	
	interact_description.format.format = \
"[outline_size=4][outline_color=BLACK][b][font_size=38]%s[/font_size][/b]
[font_size=28][b]Type:[/b] %s[/font_size]
[font_size=28][b]Environmental Impact:[/b] %s[/font_size]"
	
	interact_description.texts = [
		data.name, 
		GlobalVariables.get_enum_name(ItemEntity.Type, data.type).to_pascal_case(), 
		inventory.items[0].model.description
	] as Array[String]
	
	ExtendedQuestSystem.new_available_quest.connect(
		func(_quest: Quest):
			if _quest.id == need_quest_before_enabled.id: 
				disabled = false
	, CONNECT_ONE_SHOT
	)
	
	if need_quest_before_enabled: 
		disabled = true
	
	
func show_interact_dialog(description: BaseLabelText) -> void: 
	if disabled: 
		return
	var dialog: InteractDialog = InteractDialog.display(
		InteractDialogData.new()\
			.set_caller(
				PlayerManager.player
			)\
			.set_gui_position(interact_dialog_position.global_position)\
			.set_on_button_pressed(_on_interact)\
			.set_description(description)\
			.set_custom_ok_text("COLLECT")
	)
	
	if interact_audio: 
		dialog.ok_button.button_audio_player.disabled = true
