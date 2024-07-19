extends GUI
class_name ItemObtainedGUI


@export var item: ItemModel: 
	set(value): 
		item = value
		update()
		
		
@export var item_icon: TextureRect
@export var item_name_label: Label


func update() -> void: 
	if !is_node_ready(): 
		await ready
	if !item: 
		return
	item_icon.texture = item.item_icon
	item_name_label.text = item.name
