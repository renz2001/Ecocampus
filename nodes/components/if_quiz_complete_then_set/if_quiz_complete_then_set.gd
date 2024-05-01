extends ConditionalSetPropertyComponent
class_name IfQuizCompleteThenSet

@export var quiz: Quiz: 
	set(value): 
		quiz = value
		if !is_instance_valid(quiz): 
			return
		if !quiz.victory.is_connected(_on_quiz_victory): 
			quiz.victory.connect(_on_quiz_victory)
	
	
func _ready() -> void: 
	update_condition()
	
	
func _on_quiz_victory() -> void: 
	update_condition()
	
	
func _condition() -> bool: 
	if !is_instance_valid(quiz): 
		return false
	return quiz.victory_counter == 1




