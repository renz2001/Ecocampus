extends Camera2D
class_name MainCamera


@export var follow_node: Node2D: 
	set(value): 
		follow_node = value
		#if !follow_node.is_node_ready(): 
			#await follow_node.ready
		follow_node_component.follow(follow_node)
		
		
@export var follow_node_component: FollowNodeComponent


func _process(_delta: float) -> void: 
	zoom = Vector2(GlobalVariables.expanded_viewport_percentage.x, GlobalVariables.expanded_viewport_percentage.x)

