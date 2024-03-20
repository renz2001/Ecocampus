## Base Class for items, does not have functions but can be used as collectibles/requirements/miscellanous. 
extends Resource
class_name Item

@export var name: StringName
@export var description: String
@export var item_icon: CompressedTexture2D

var stack: PointCounter

func _init() -> void: 
	stack = PointCounter.new()
	stack.starting_value = 1
	stack.minimum_hit.connect(
		func(): 
			free()
	)


func subtract_from_same(item: Item) -> Item: 
	if item != self: 
		return
	stack.subtract(item.stack.current)
	return self
	
	
