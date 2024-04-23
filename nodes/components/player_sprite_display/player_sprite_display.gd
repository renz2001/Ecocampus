@tool
extends Sprite2D
class_name PlayerSpriteDisplay


@export var player: Player: 
	set(value): 
		player = value
		update()
		

func update() -> void: 
	texture = player.current_cosmetic.get_icon(player.gender)
