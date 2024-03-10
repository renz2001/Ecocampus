extends PopupMenu
class_name DropdownPopup

var items: Array[DropdownPopupItem]: 
	set(value): 
		items = value
		if items.is_empty(): 
			clear() 
		for item: DropdownPopupItem in items: 
			add_item(item.name)


func activate(pos: Vector2, _items: Array[DropdownPopupItem]) -> void: 
	show()
	position = pos
	items = _items


func _on_index_pressed(index: int) -> void: 
	if items.is_empty(): 
		return
	items[index].function.call()


func _on_popup_hide() -> void:
	items = []
