extends NodeComponent
class_name OnInteractComponent

@export var entity: EntityNode


func _ready() -> void: 
	entity.interacted.connect(_on_interact)


func _on_interact() -> void: 
	pass
