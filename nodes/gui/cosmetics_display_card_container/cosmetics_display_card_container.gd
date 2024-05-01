@tool
extends HBoxContainer
class_name CosmeticsDisplayCardContainer

signal updated

enum OverrideCosmeticState {
	NONE, 
	LOCKED, 
	UNLOCKED,
}

@export var cosmetics_collection: CosmeticsCollection: 
	set(value): 
		if !is_node_ready(): 
			await ready
		if cosmetics_collection: 
			for cosmetic: Cosmetic in cosmetics_collection.cosmetics: 
				if !cosmetic.unlocked.is_connected(_on_cosmetic_unlocked): 
					continue
				cosmetic.unlocked.disconnect(_on_cosmetic_unlocked)
			
		cosmetics_collection = value
			
			
		if cosmetics_collection: 
			for cosmetic: Cosmetic in cosmetics_collection.cosmetics: 
				cosmetic.unlocked.connect(_on_cosmetic_unlocked)
			update()
		else: 
			clear()
			
@export var only_show_unlocked: bool: 
	set(value): 
		only_show_unlocked = value
		update()


@export var show_default_cosmetic: bool: 
	set(value): 
		show_default_cosmetic = value
		update()
		
@export var override_cosmetic_state: OverrideCosmeticState: 
	set(value): 
		override_cosmetic_state = value
		update()
		
@export var card_theme_type_variation: String = ""
@export var override_custom_minimum: Vector2


func _on_cosmetic_unlocked() -> void: 
	update()
	

func update() -> void: 
	if !is_node_ready(): 
		await ready
	if cosmetics_collection == null: 
		return
	clear()
	for cosmetic: Cosmetic in cosmetics_collection.cosmetics: 
		if cosmetic.is_default && !show_default_cosmetic: 
			continue
		var gui: CosmeticDisplayCard = CosmeticDisplayCard.create(self, cosmetic, card_theme_type_variation)
		if override_custom_minimum != Vector2.ZERO: 
			gui.custom_minimum_size = override_custom_minimum
			#gui.size = custom_minimum_size
		match override_cosmetic_state: 
			OverrideCosmeticState.LOCKED: 
				gui.state = Cosmetic.CosmeticState.LOCKED
			OverrideCosmeticState.UNLOCKED: 
				gui.state = Cosmetic.CosmeticState.UNLOCKED
				
	if only_show_unlocked: 
		for child: CosmeticDisplayCard in get_children(): 
			if child.cosmetic.state == Cosmetic.CosmeticState.LOCKED: 
				child.visible = false
		#printerr(cosmetic.name)
		#printerr(cosmetic.female_icon)
	updated.emit()
	
	
func clear() -> void: 
	for child: Node in get_children(): 
		child.queue_free()


func get_visible_card_at(index: int) -> Control: 
	#return NodeTools.get_item_from_array(
		#get_children(), 
		#func(item, i): 
			#return i == index && item.is_visible_in_tree()
	#)
	var children: Array[Node] = get_children().filter(
		func(item): 
			return item.visible
	)
	for i: int in children.size(): 
		var child: Node = children[i]
		if i == index: 
			return child
	return null
