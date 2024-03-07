extends NodeComponent 
class_name PrintColor 


@export var node: Node
@export var color: Color
@export var node_name_color: Color = Color("0000ff")
@export var value_color: Color = Color("ff0000")
@export var automatic_value_color: bool = true
@export var use_spaces_for_node_name: bool


func out(output: String) -> void: 
	print_rich("[color=%s]%s" % [color.to_html(), output])
	
	
func out_debug(output: String) -> void: 
	var node_name: String = node.name
	if use_spaces_for_node_name: 
		node_name = node_name.capitalize()
	print_rich("[color=%s]%s: [color=%s]%s" % [node_name_color.to_html(), node_name, color.to_html(), output])
	
	
func out_debug_wvalue(output: String, val) -> void: 
	var final_color: Color = value_color
	if !(val is String): 
		val = str(val)
	if automatic_value_color: 
		var real_value = str_to_var(val)
		if real_value == true: 
			final_color = GlobalVariables.COLOR_EDITOR_GREEN
		elif real_value == false: 
			final_color =  GlobalVariables.COLOR_EDITOR_RED
		elif real_value is Vector2: 
			final_color =  GlobalVariables.COLOR_EDITOR_GREEN
		else: 
			final_color =  GlobalVariables.COLOR_EDITOR_YELLOW
			
	out_debug("%s: [color=%s]%s" % [output, final_color.to_html(), val])
	
	
