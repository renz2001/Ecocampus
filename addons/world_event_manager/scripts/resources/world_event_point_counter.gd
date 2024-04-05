## Seperate from WorldEventPointCounterComponent (lol idk why) 
extends Resource
class_name WorldEventPointCounter

@export var increment_on_event: String

@export var counter: PointCounter

## Listens for the counter's signal
@export var call_event_from_counter_signal: String

## (Optional) Calls this event when the listen_to_signal is emitted
@export var call_event: WorldEventCall


func _init() -> void: 
	WorldEventManager.event_called.connect(_on_event_called)
	if !call_event_from_counter_signal.is_empty(): 
		counter.connect(call_event_from_counter_signal, _on_signal)
	
	
func _on_signal(value: float) -> void: 
	WorldEventManager.call_event(call_event.event, PlayerManager.player)
	
	
func _on_event_called(event: String, by: Node, args: Array = []) -> void: 
	counter.increment()
	
	
