## Base Class for items, does not have functions but can be used as collectibles/requirements/miscellanous. 
extends Resource
class_name ItemModel

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


func subtract_from_same(item: ItemModel) -> ItemModel: 
	if item != self: 
		return
	stack.subtract(item.stack.current)
	return self
	
	
func _to_string() -> String: 
	return "%s<stack_count:%s>" % [name, stack.current]


func to_item() -> Item: 
	var item: Item = Item.new() 
	item.model = self
	return item
	
	
