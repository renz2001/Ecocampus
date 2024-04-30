extends ConditionalSetPropertyComponent
class_name IfAutoloadStateEventSetProperty

enum StateEvent {
	STATE_ENTERED, 
	STATE_EXITED
}

@export var autoload: String
@export var property: String
@export var state_event: StateEvent


func _ready() -> void: 
	super._ready()
	var autoload_node: Node = NodeTools.get_autoload(self, autoload)
	var state: State = autoload_node.get(property) 
	
	match state_event: 
		StateEvent.STATE_ENTERED: 
			state.state_entered.connect(update_condition)
		StateEvent.STATE_EXITED: 
			state.state_exited.connect(update_condition)


func _condition() -> bool: 
	return true
