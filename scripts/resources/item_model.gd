## Base Class for items, does not have functions but can be used as collectibles/requirements/miscellanous. 
extends Resource
class_name ItemModel

enum Type {
	NON_BIODEGRADABLE, 
	BIODEGRADABLE, 
	RECYCLABLE, 
	TOOL
}

@export var name: StringName
@export_multiline var description: String
@export var item_icon: Texture2D
@export var type: Type

@export var maximum_stack: int = 12

func _to_string() -> String: 
	return "%s(maximum_stack:%s)" % [name, maximum_stack]


func to_item_stack() -> ItemStack: 
	var item: ItemStack = ItemStack.new() 
	item.model = self
	return item
	
	
func is_tool() -> bool: 
	return type == Type.TOOL
	
	
