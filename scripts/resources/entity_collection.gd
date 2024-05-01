extends Resource
class_name EntityCollection


@export var entities: Array[Entity]


func reset() -> void: 
	for entity: Entity in entities: 
		entity.reset()
