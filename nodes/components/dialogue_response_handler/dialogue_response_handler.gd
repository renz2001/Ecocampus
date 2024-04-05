extends NodeComponent
class_name DialogueResponseHandler


signal responded(value: String)


func respond(value: String) -> void: 
	responded.emit(value)
	
	
