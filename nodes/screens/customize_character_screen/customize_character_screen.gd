@tool
extends GUI
class_name CustomizeCharacterScreen 


@export var cosmetics_collection: CosmeticsCollection: 
	set(value): 
		cosmetics_collection = value
		if !is_node_ready(): 
			await ready
		update()
		
		
@export var cosmetic_select_card: CosmeticSelectCard
@export var cosmetic_display_card_container: CosmeticsDisplayCardContainer


func update() -> void: 
	cosmetic_select_card.cosmetics_collection = cosmetics_collection
	cosmetic_display_card_container.cosmetics_collection = cosmetics_collection


func _activated() -> void: 
	super._activated()
	update()
	
	
