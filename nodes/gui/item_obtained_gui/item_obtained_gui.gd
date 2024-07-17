extends GUI
class_name ItemObtainedGUI


@export var item: ItemModel: 
	set(value): 
		item = value
		if !is_node_ready(): 
			await ready
		item_icon.texture = item.item_icon
		item_name_label.text = item.name
		
		
@export var item_icon: TextureRect
@export var item_name_label: Label
