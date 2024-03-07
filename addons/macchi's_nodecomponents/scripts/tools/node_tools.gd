extends Object
class_name NodeTools

# TODO: To test
## Callable(child, index), Return true to stop exploring the child, false for opposite, null to break. 
static func explore_children(parent: Node, callable: Callable) -> void: 
	var chilren: Array[Node] = parent.get_children()
	for i: int in chilren.size(): 
		var child: Node = chilren[i]
		if callable.call(child, i): 
			continue
		elif child.get_child_count() > 0: 
			explore_children(child, callable)


static func disable(node: Node, value: bool = true) -> void: 
	node.visible = value
	if node is CollisionObject2D: 
		node.disabled = value
	elif node is Area2D: 
		node.monitorable = !value
		node.monitoring = !value
	elif node is CharacterBody2D: 
		for child in node.get_children(): 
			if child is CollisionObject2D: 
				child.disabled = value
				
				
static func disable_nodes(list: Array, value: bool) -> void: 
	for child in list: 
		NodeTools.disable(child, value)
		
		
static func get_collisions(parent: Node) -> Array[Node]: 
	var collisions: Array[Node] = []
	for child: Node in parent.get_children(): 
		if child is CollisionShape2D or child is CollisionPolygon2D: 
			collisions.append(child)
	return collisions
	
	
static func move_collisions(from: Node, to: Node, duplicate_collisions: bool = false) -> void: 
	for child: Node in NodeTools.get_collisions(from): 
		if duplicate_collisions: 
			var dupe: Node = child.duplicate()
			to.add_child(dupe)
		else: 
			# FIXME: Doesn't work if the CollisionShape is from StaticBody
			if from is StaticBody2D: 
				var dupe: Node = child.duplicate()
				child.disabled = true
				to.add_child(dupe)
			else: 
			#child.disabled = true
				from.remove_child.call_deferred(child)
				to.add_child.call_deferred(child)
			
			
## Returns an item from an array if the method returns true, else returns null. 
## Method is func(item, index)
static func get_item_from_array(array: Array, method: Callable): 
	for i in array.size(): 
		var item = array[i]
		var method_return: bool = method.call(item, i)
		if method_return: 
			continue
		return item
	return null
#func _get_all_save_components(parent: Node) -> Array[FollowerSaveComponent]: 
	#var save_components_in_node: Array[FollowerSaveComponent] = []
	#for child: Node in parent.get_children(): 
		#if child is StateChart || child.name == "StateChartDebugger": 
			#continue
		#elif child is FollowerSaveComponent && !child is MasterSaveComponent: 
			#save_components_in_node.append(child)
		#elif child.get_child_count() > 0: 
			#save_components_in_node.append_array(_get_all_save_components(child))
	#return save_components_in_node
