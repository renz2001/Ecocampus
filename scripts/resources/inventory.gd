extends Resource
class_name Inventory

signal items_changed(previous_items: Array[Item], new_items: Array[Item], changed_by: Node )

signal items_set(new_items: Array[Item])

signal items_added(new_items: Array[Item])
signal item_added(new_item: Item)

signal items_taken(new_items: Array[Item], taken_by: Node)
signal item_taken(new_item: Item=, taken_by: Node)

signal items_removed(new_items: Array[Item], taken_by: Node)
signal item_removed(new_item: Item, removed_by: Node)

@export var items: Array[Item] = []

@export var max_items: int = -1


func set_items(new_items: Array[Item]) -> void: 
	if new_items.size() > max_items: 
		return
	items = new_items
	items_set.emit(new_items)


func add_items(new_items: Array[Item]) -> void: 
	if new_items.size() > max_items: 
		return
	items.append_array(new_items)
	items_added.emit(new_items)


func add_item(new_item: Item) -> void:
	items.append(new_item)
	item_added.emit(new_item)


func take_all_items(taken_by) -> Array[Item]:
	var all_items: Array[Item] = items.duplicate()
	items.clear()
	item_taken.emit(taken_by, taken_by)
	return all_items


func take_items(new_items: Array[Item], taken_by: Node) -> Array[Item]:
	var _items: Array[Item] = []
	for new_item in new_items:
		_items.append(items.pop_at(find_item(new_item)))
	items_taken.emit(_items, taken_by)
	return _items


func take_item(new_item: Item, taken_by: Node) -> Item:
	var _item = items.pop_at(find_item(new_item))
	item_taken.emit(_item, taken_by)
	return _item


func remove_items(new_items: Array[Item], taken_by: Node) -> void:
	var taken_items: Array[Item] = []
	for new_item in new_items:
		taken_items.append(items.pop_at(find_item(new_item)))
	items_removed.emit(taken_items, taken_by)


func remove_item(new_item: Item, removed_by: Node) -> void:
	items.erase(new_item)
	item_removed.emit(new_item, removed_by)


func has_item(item: Item) -> bool:
	if items.find(item) > -1:
		return true
	return false


func find_item(item: Item) -> int:
	return items.find(item)


func has_item_by_name(item_name: StringName) -> bool:
	if find_item_by_name(item_name) > -1:
		return true
	return false


func find_item_by_name(item_name: StringName) -> int:
	for i in items.size():
		if items[i].item_name == item_name:
			return i
	return -1


func is_empty() -> bool: 
	if items.is_empty(): 
		return true
	return false


func _to_string() -> String:
	var _items: String = ""
	for index in items.size(): 
		if index == 0: 
			_items += items[index].item_name
		_items += " , " + items[index].item_name
	return _items
	
	
