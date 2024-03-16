extends EntityNode
class_name NPCNode


@export var on_interact_dialogue: DialogueArguments
@export var dialogue_starter: DialogueStarter


func _interact() -> void: 
	dialogue_starter.dialogue = on_interact_dialogue
	dialogue_starter.start()
	
	
