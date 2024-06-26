@tool
extends GUI
class_name CosmeticDisplayCard

@export var player: Entity: 
	set(value): 
		player = value
		update()
		if !Engine.is_editor_hint(): 
			player.gender_changed.connect(update)

@export var gender: GlobalEnums.Gender: 
	set(value): 
		gender = value
		if gender == GlobalEnums.Gender.NONE: 
			return
		player.gender = gender
		update()
		
@export var cosmetic: Cosmetic: 
	set(value): 
		cosmetic = value
		if !is_node_ready(): 
			await ready
		if !cosmetic.unlocked.is_connected(_on_cosmetic_unlocked): 
			cosmetic.unlocked.connect(_on_cosmetic_unlocked)
		update()

@export var state: Cosmetic.CosmeticState: 
	set(value): 
		state = value
		if !is_node_ready(): 
			await ready
		match state: 
			Cosmetic.CosmeticState.UNLOCKED: 
				state_view.current_tab = 1
			Cosmetic.CosmeticState.LOCKED: 
				state_view.current_tab = 0

@export var state_view: TabContainer
@export var cosmetic_icon: TextureRect
@export var cosmetic_icon_2: TextureRect
@export var panel_container: PanelContainer
@export var points_label: Label
@export var cosmetic_name_label: Label
@export var cosmetic_name_label_2: Label

static func create(parent: Node, _cosmetic: Cosmetic, theme_variation: String = "") -> CosmeticDisplayCard: 
	var gui: CosmeticDisplayCard = GUICollection.cosmetic_display_card.instantiate()
	parent.add_child(gui)
	gui.cosmetic = _cosmetic
	gui.panel_container.theme_type_variation = theme_variation
	#print(gui.cosmetic)
	return gui
	
	
func update() -> void: 
	if !is_node_ready(): 
		await ready
		
	if cosmetic == null: 
		cosmetic_icon.texture = null
		return
	cosmetic_icon.texture = cosmetic.get_icon(player.gender)
	cosmetic_icon_2.texture = cosmetic.get_icon(player.gender)
	state = cosmetic.state
	cosmetic_name_label.text = cosmetic.get_current_name(player.gender)
	cosmetic_name_label_2.text = cosmetic.get_current_name(player.gender)
	points_label.text = str(cosmetic.medals_required)


func _on_unlock_button_pressed() -> void:
	GlobalData.achievements_tracker.unlock_cosmetic(cosmetic)
	
	
func _on_cosmetic_unlocked() -> void: 
	update()
	
