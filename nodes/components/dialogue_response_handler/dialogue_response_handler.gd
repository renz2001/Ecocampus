extends NodeComponent
class_name DialogueResponseHandler

@export var print_color: PrintColor: 
	set(value): 
		print_color = value
		print_color.owner = self

signal responded(value: String)


func respond(value: String) -> void: 
	DialogueManager.dialogue_ended.connect(
		func(_dialogue: DialogueResource): 
			responded.emit(value)
			print_color.out_debug_wvalue("received response", value)
	)
	
	
