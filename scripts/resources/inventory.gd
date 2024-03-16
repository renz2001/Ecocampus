extends Resource
class_name Inventory

signal items_changed(previous_items: Array[Item], new_items: Array[Item], changed_by: Node )

signal items_set(new_items: Array[Item])

signal items_added(new_items: Array[Item])
signal item_added(new_item: Item)

signal items_taken_from_inventory(by: Node, new_items: Array[Item])

signal items_removed(by: Node, new_items: Array[Item])
signal item_removed(by: Node, new_item: Item)

@export var items: Array[Item] = []

@export var max_items: int = -1

var owner: Object
var _print_color: PrintColor
var _max_items_error: Callable = func(val): _print_color.out_debug_wvalue("Cannot add more items since it has reached it's maximum. The new items", val)

func _init() -> void: 
	_print_color = PrintColor.new()
	_print_color.owner = owner
	_print_color.color = Color("b4ff00")


func set_items(new_items: Array[Item]) -> void: 
	if new_items.size() >= max_items: 
		_max_items_error.call(new_items)
		return
	items = new_items
	items_set.emit(new_items)


func add_items(new_items: Array[Item]) -> void: 
	if new_items.size() >= max_items: 
		_max_items_error.call(new_items)
		return
	items.append_array(new_items)
	items_added.emit(new_items)


func add_item(new_item: Item) -> void: 
	if items.size() >= max_items: 
		_max_items_error.call(new_item)
		return
	for item: Item in items: 
		if new_item == item: 
			item.stack.add(new_item.stack.current)
			return
	items.append(new_item)
	item_added.emit(new_item)


func take_from_inventory(by: Object, inventory: Inventory) -> void: 
	if self == inventory: 
		_print_color.out_debug_wvalue("Cannot take items from itself", inventory)
		return
	var itemss: Array[Item] = inventory.clear(by)
	add_items(itemss)
	items_taken_from_inventory.emit(by, itemss)


#func take_items_from_inventory(by: Object, inventory: Inventory) -> void: 
	#if self == inventory: 
		#_print_color.out_debug_wvalue("Cannot take items from itself", inventory)
		#return
	#add_items(inventory.clear(by))
	
	
func clear(by: Object) -> Array[Item]:
	var all_items: Array[Item] = items.duplicate()
	items.clear()
	items_removed.emit(by, all_items)
	return all_items


func remove_items(by: Object, new_items: Array[Item]) -> Array[Item]:
	var _items: Array[Item] = []
	for new_item: Item in new_items:
		_items.append(remove_item(by, new_item))
	items_removed.emit(_items, by)
	return _items


func remove_item(by: Object, new_item: Item) -> Item: 
	#var _item = items.pop_at(items.find(new_item))
	var item: Item = items[items.find(new_item)]
	item.subtract_from_same(new_item)
	item_removed.emit(by, item)
	return item

func has_item_name(item_name: StringName) -> bool:
	return find_item_by_name(item_name) > -1


func find_item_by_name(item_name: StringName) -> int:
	for i in items.size():
		if items[i].item_name == item_name:
			return i
	return -1



func _to_string() -> String:
	var _items: String = ""
	for index in items.size(): 
		if index == 0: 
			_items += items[index].item_name
		_items += " , " + items[index].item_name
	return _items
	
	
