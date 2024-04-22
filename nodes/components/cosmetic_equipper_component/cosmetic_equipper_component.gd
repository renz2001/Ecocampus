@tool
extends NodeComponent
class_name CosmeticEquipperComponent

#@export var default_cosmetic: Cosmetic: 
	#set(value): 
		#default_cosmetic = value
		#if current_cosmetic == null && !Engine.is_editor_hint(): 
			#current_cosmetic = default_cosmetic
		#
		#
#@export var current_cosmetic: Cosmetic: 
	#set(value): 
		#current_cosmetic = value
		#if !is_node_ready(): 
			#await ready
		#male_sprite_node.texture = current_cosmetic.male_sprite
		#female_sprite_node.texture = current_cosmetic.female_sprite
@export var player: Player: 
	set(value): 
		player = value
		update()

@export var male_sprite_node: Sprite2D
@export var female_sprite_node: Sprite2D


func update() -> void: 
	if !is_node_ready(): 
		await ready
	male_sprite_node.texture = player.get_current_cosmetic().male_sprite
	female_sprite_node.texture = player.get_current_cosmetic().female_sprite
