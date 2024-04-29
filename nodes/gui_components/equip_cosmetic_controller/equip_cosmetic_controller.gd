extends NodeComponent
class_name EquipCosmeticController


@export var cosmetic: Cosmetic
@export var player: Player


func toggle() -> void: 
	if player.current_cosmetic.name == cosmetic.name: 
		unequip()
	else: 
		equip()


func equip() -> void: 
	player.equip_cosmetic(cosmetic)
	
	
func unequip() -> void: 
	player.unequip_cosmetic()
	
	
