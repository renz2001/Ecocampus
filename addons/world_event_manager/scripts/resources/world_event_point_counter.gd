## Seperate from WorldEventPointCounterComponent since it cannot contain nodes. 
extends SaveableResource
class_name WorldEventPointCounter

@export var disabled: bool: 
	set(value): 
		disabled = value
		if disabled: 
			WorldEventManager.event_called.disconnect(_on_event_called)
		else: 
			if !WorldEventManager.event_called.is_connected(_on_event_called): 
				WorldEventManager.event_called.connect(_on_event_called)

## Will increment the counter if this event is called
@export var increment_on_event: String

## Will increment if increment on event works and this has arguments from the event that was called. 
@export var increment_if_has_similar_arguments: Array

@export var maximum_points: float: 
	set(value): 
		maximum_points = value
		counter.maximum = maximum_points

## (Optional) Calls this event when the listen_to_signal is emitted
@export var call_event: WorldEventCall

var counter: PointCounter


func _init() -> void: 
	super._init()
	init()


func init() -> void: 
	counter = PointCounter.new() 
	counter.when_maximum_stay = true
	counter.starting_value = 0
	WorldEventManager.event_called.connect(_on_event_called)
	if call_event: 
		counter.maximum_hit.connect(_on_signal, CONNECT_ONE_SHOT)
	
	
func _on_signal(value: float) -> void: 
	WorldEventManager.call_event(call_event.event, PlayerManager.player)
	
	
func _on_event_called(event: String, by: Node, args: Array = []) -> void: 
	if increment_on_event == event && has_similar_arguments(args): 
		counter.increment()
	
	
func has_similar_arguments(args: Array) -> bool: 
	return args.any(
		func(item): 
			return item in increment_if_has_similar_arguments
	)
	

func _save_properties() -> PackedStringArray: 
	return [
		"maximum_points", 
		"counter"
	]
	
	
func _to_string() -> String: 
	return "WorldEventPointCounter#%s(increment_on_event:%s, current:%s)" % [increment_on_event, get_instance_id(), counter.current]

