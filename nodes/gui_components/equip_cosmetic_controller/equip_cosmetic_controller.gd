extends NodeComponent
class_name EquipCosmeticController


@export var cosmetic: Cosmetic
@export var player: Player


func toggle() -> void: 
	if player.is_equipped(): 
		unequip()
	else: 
		equip()


func equip() -> void: 
	player.equip_cosmetic(cosmetic)
	
	
func unequip() -> void: 
	player.unequip_cosmetic()
	
	
