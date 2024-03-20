@tool
extends GUI
class_name CosmeticDisplayCard

enum CardState {
	LOCKED, 
	UNLOCKED
}

@export var cosmetic: Cosmetic: 
	set(value): 
		cosmetic = value
		if !is_node_ready(): 
			await ready
		cosmetic_icon.texture = cosmetic.icon

@export var state: CardState: 
	set(value): 
		state = value
		match state: 
			CardState.UNLOCKED: 
				state_view.current_tab = 1
			CardState.LOCKED: 
				state_view.current_tab = 0

@export var state_view: TabContainer
@export var cosmetic_icon: TextureRect
@export var locked_button_state_view: TabContainer
