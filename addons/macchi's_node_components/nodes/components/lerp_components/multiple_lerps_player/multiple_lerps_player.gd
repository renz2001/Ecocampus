@tool
extends MultipleSignalsListener
class_name MultipleLerpsPlayer

@export_range(0, 1) var percentage: float: 
	set(value): 
		percentage = value
		for lerpc: BaseLerpComponent in children_nodes.get_children(): 
			lerpc.percentage = percentage


func play() -> void: 
	for lerpc: BaseLerpComponent in children_nodes.get_children(): 
		lerpc.play()
		
		
