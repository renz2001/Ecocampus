@tool
extends InteractableEntityNode
class_name UseToolToEnableEntity


@export var entity_to_enable: EntityNode

func _ready() -> void: 
	entity_to_enable.disabled = true
	
	
func _on_item_accepted(_item_stack: ItemStack) -> void:
	entity_to_enable.disabled = false
	disabled = true
	hide()


func _on_item_rejected(_item_stack: ItemStack) -> void:
	pass # Replace with function body.


func _interact() -> void: 
	pass
	
	
