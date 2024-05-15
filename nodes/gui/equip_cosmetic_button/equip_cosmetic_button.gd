extends Button
class_name EquipCosmeticButton

@export var cosmetic: Cosmetic: 
	set(value): 
		cosmetic = value
		update()

@export var equip_cosmetic_controller: EquipCosmeticController


func _on_pressed() -> void:
	equip_cosmetic_controller.cosmetic = cosmetic
	equip_cosmetic_controller.toggle()
	update()
	
	
func update() -> void: 
	var player: Player = equip_cosmetic_controller.player
	if player.current_cosmetic.is_default: 
		text = "Equip"
	elif player.current_cosmetic.name == cosmetic.name: 
		text = "Unequip"
	else: 
		text = "Equip"
	
	printerr(player.current_cosmetic.name)
	printerr(player.is_equipped())
	if !player.current_cosmetic.is_default && player.is_equipped(): 
		disabled = false
	elif cosmetic.is_default: 
		disabled = true
	else: 
		disabled = false
