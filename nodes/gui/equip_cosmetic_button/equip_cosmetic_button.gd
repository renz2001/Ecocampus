extends Button
class_name EquipCosmeticButton

@export var cosmetic: Cosmetic: 
	set(value): 
		cosmetic = value
		if cosmetic.is_default: 
			disabled = true
		else: 
			disabled = false

@export var equip_cosmetic_controller: EquipCosmeticController


func _on_pressed() -> void:
	equip_cosmetic_controller.cosmetic = cosmetic
	equip_cosmetic_controller.toggle()
	update()
	
	
func update() -> void: 
	if equip_cosmetic_controller.player.is_equipped(): 
		text = "Unequip"
	else: 
		text = "Equip"
	
	
