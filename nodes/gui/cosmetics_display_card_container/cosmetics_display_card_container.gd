@tool
extends HBoxContainer
class_name CosmeticsDisplayCardContainer

enum OverrideCosmeticState {
	NONE, 
	LOCKED, 
	UNLOCKABLE, 
	UNLOCKED,
}

@export var cosmetics_collection: CosmeticsCollection: 
	set(value): 
		cosmetics_collection = value
		if !is_node_ready(): 
			await ready
		if cosmetics_collection: 
			update()
		else: 
			clear()
@export var override_cosmetic_state: OverrideCosmeticState
@export var card_theme_type_variation: String = ""

func update() -> void: 
	clear()
	
	for cosmetic: Cosmetic in cosmetics_collection.cosmetics: 
		var gui: CosmeticDisplayCard = CosmeticDisplayCard.create(self, cosmetic, card_theme_type_variation)
		match override_cosmetic_state: 
			OverrideCosmeticState.LOCKED: 
				gui.state = Cosmetic.CosmeticState.LOCKED
			OverrideCosmeticState.UNLOCKED: 
				gui.state = Cosmetic.CosmeticState.UNLOCKED
			OverrideCosmeticState.UNLOCKABLE: 
				gui.state = Cosmetic.CosmeticState.UNLOCKABLE
		#printerr(cosmetic.name)
		#printerr(cosmetic.female_icon)
	
func clear() -> void: 
	for child: Node in get_children(): 
		child.queue_free()
