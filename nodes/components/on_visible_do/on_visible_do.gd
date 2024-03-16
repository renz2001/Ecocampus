extends NodeComponent
class_name OnVisibleDo

@export var node: CanvasItem: set = set_node


func _ready() -> void: 
	if !node.is_node_ready(): 
		await node.ready
	if node.visible: 
		_on_visible(true)
	else: 
		node.visibility_changed.connect(_on_visible)
		
		
## Virtual function
func _on_visible(value: bool) -> void: 
	pass


## Should be overriden
func set_node(value: CanvasItem) -> void: 
	node = value
