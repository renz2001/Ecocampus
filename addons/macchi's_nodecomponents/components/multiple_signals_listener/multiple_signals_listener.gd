## Listens to signals, signals must not have arguments or else this will not work. 
extends NodeComponent
class_name MultipleSignalsListener

signal all_conditions_met

## Type here the signals you want it to listen to
@export var signals: PackedStringArray

## You can add nodes to listen manually or just put it as a child node in ChildrenNodes 
@export var nodes_to_listen: Array[Node]
@export_group("Dependencies")
@export var children_nodes: Node

var logic_gate: LogicGate = LogicGate.new()

func _ready() -> void: 
	nodes_to_listen.append_array(children_nodes.get_children())
	var new_conditions_size: int = 0
	for i: int in nodes_to_listen.size(): 
		var node: Node = nodes_to_listen[i]
		for s: String in signals: 
			if node.has_signal(s): 
				new_conditions_size += 1
				node.connect(s, _on_signal_heard.bind(node, s, i)) 
	logic_gate.conditions.resize(new_conditions_size)
	logic_gate.conditions.fill(false)
	
	
func _on_signal_heard(node: Node, s: String, index: int) -> void: 
	logic_gate.conditions[index] = true
	node.disconnect(s, _on_signal_heard)
	if logic_gate.is_true(): 
		all_conditions_met.emit()
	
