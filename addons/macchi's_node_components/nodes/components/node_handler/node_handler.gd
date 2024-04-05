extends NodeComponent
class_name NodeHandler 


signal entered_node(entered_node: Node)
signal exited_node(exited_node: Node)

signal changed_node(new_node: Node) 

# Disabled, disables you to change node or handle input process, while disable_processes only disables the input process
@export var starting_node: Node
@export var disabled: bool = false:
	set(value):
		disabled = value
@export var nodes: Node
		
@export_group("DEBUGGING")
@export var debug: bool = false: 
	get: 
		if !OS.is_debug_build(): 
			return false
		return debug
@export var should_test_start_node: bool = false
@export var test_start_node: Node

var current_node: Node

@onready var current_node_label: Label = get_node("%CurrentStateLabel") if (has_node("%CurrentStateLabel")) else null


func _ready() -> void: 
	init()
	
	
func init() -> void: 
	if disabled: 
		return
	if debug:
		print("%s's available nodes are: %s" % [get_parent().name, get_all_nodes()])
	#for node in get_all_nodes(): 
		#node.init(self, node_machine_owner)

	# Initialize with a default node of idle
	if is_instance_valid(test_start_node) && should_test_start_node: 
		change_node(test_start_node)
		return
	change_node(starting_node)
	
	
func get_all_nodes() -> Array: 
	return nodes.get_children() 


func change_node_by_name(new_node_name: String) -> void:
	change_node(nodes.get_node(new_node_name)) 


func change_node(new_node: Node) -> void: 
	if current_node == new_node: 
		return
	if disabled: 
		printerr("StateMachine (%s): StateMachine is disabled" % [owner])
		return
	if !is_instance_valid(new_node): 
		printerr("StateMachine (%s): Change to new node is null. " % [owner])
		return 
	if current_node:
		if debug:
			print("%s: exited node %s/%s\n" % [get_parent().name, current_node.get_parent().name, current_node.name])
		#current_node.exit()
		current_node.set_process(false)
		exited_node.emit(current_node)
	current_node = new_node
	if debug: 
		print("\n%s: entered node %s/%s" % [get_parent().name, current_node.get_parent().name, current_node.name])
	#current_node.enter()
	current_node.set_process(true)
	entered_node.emit(current_node)
	changed_node.emit(current_node)
	if current_node_label:
		current_node_label.set_text(current_node.name)


func is_current_node_name(node_name: String) -> bool: 
	return is_current_node(get_node(node_name))


func is_current_node(node: Node) -> bool:
	#print("current node: ", current_node == node) 
	if current_node == node: 
		return true
	return false


func _get_configuration_warnings() -> PackedStringArray: 
	var warnings: PackedStringArray = []
	if starting_node == null: 
		warnings.append("Error: StoryPlayer (%s): Starting node is not set!" % [owner])
	return warnings


