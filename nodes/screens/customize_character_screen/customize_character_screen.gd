@tool
extends GUI
class_name CustomizeCharacterScreen 

# FIXME: Fix CosmeticDisplayCard for not updating. 

@export var cosmetics_collection: CosmeticsCollection: 
	set(value): 
		cosmetics_collection = value
		if !is_node_ready(): 
			await ready
		cosmetic_select_card.cosmetics_collection = cosmetics_collection
		cosmetic_display_card_container.cosmetics_collection = cosmetics_collection

@export var cosmetic_select_card: CosmeticSelectCard
@export var cosmetic_display_card_container: CosmeticsDisplayCardContainer


