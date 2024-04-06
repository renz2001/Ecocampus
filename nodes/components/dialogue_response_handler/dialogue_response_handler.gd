extends NodeComponent
class_name DialogueResponseHandler


signal responded(value: String)


func respond(value: String) -> void: 
	DialogueManager.dialogue_ended.connect(
		func(_dialogue: DialogueResource): 
			responded.emit(value)
	)
	
	
