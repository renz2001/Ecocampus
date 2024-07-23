extends NodeComponent
class_name DialogueResponseHandler

signal responded(value: String)

@export var owner_node: Node
@export var print_color: PrintColor: 
	set(value): 
		print_color = value
		print_color.owner = self



func respond(value: String, when_dialogue_ended: bool = true) -> void: 
	if when_dialogue_ended: 
		DialogueManager.dialogue_ended.connect(_on_dialogue_ended.bind(value), CONNECT_ONE_SHOT)
	else: 
		_on_dialogue_ended(null, value)
	
	
func _on_dialogue_ended(_dialogue: DialogueResource, value: String) -> void: 
	responded.emit(value)
	print_color.out_debug_wvalue("received response", value)
	
	
func _exit_tree() -> void: 
	if DialogueManager.dialogue_ended.is_connected(_on_dialogue_ended): 
		DialogueManager.dialogue_ended.disconnect(_on_dialogue_ended)
	
	
