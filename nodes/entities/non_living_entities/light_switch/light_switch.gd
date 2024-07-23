@tool
extends EntityNode
class_name LightSwitch

@export var light_bulbs: Array[LightBulb]


func _interact() -> void: 
	for bulb: LightBulb in light_bulbs: 
		bulb.interact()


#func _on_off_state_entered() -> void:
	#pass # Replace with function body.
#
#
#func _on_on_state_entered() -> void:
	#pass # Replace with function body.
#
