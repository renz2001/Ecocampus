@tool
extends GUI
class_name CosmeticDisplayCard

@export var gender: GlobalEnums.Gender: 
	set(value): 
		gender = value
		cosmetic = cosmetic
		
@export var cosmetic: Cosmetic: 
	set(value): 
		cosmetic = value
		if !is_node_ready(): 
			await ready
		if cosmetic: 
			cosmetic_icon.texture = cosmetic.get_icon(gender)
			#print("D")
		else: 
			cosmetic_icon.texture = null
			#printerr("A")

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
@export var locked_button_state_view: TabContainer
@export var panel_container: PanelContainer


static func create(parent: Node, _cosmetic: Cosmetic, theme_variation: String = "") -> CosmeticDisplayCard: 
	var gui: CosmeticDisplayCard = GUICollection.cosmetic_display_card.instantiate()
	parent.add_child(gui)
	gui.cosmetic = _cosmetic
	gui.panel_container.theme_type_variation = theme_variation
	#print(gui.cosmetic)
	return gui
	
	
