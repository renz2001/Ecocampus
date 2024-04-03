extends NodeComponent
class_name OnVisibleDo

@export var node: CanvasItem: set = set_node
@export var on_hide: bool


func _ready() -> void: 
	if !node.is_node_ready(): 
		await node.ready
	node.visibility_changed.connect(_on_visibility_changed)
		
		
# FIXME: on_hide doesn't work
func _on_visibility_changed() -> void: 
	if !on_hide: 
		if node.visible: 
			_on_visible()
	else: 
		if !node.visible: 
			_on_visible()
	
	
## Virtual function
func _on_visible() -> void: 
	pass
	
	
## Should be overriden
func set_node(value: CanvasItem) -> void: 
	node = value

