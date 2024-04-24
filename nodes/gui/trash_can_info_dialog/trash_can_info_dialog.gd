extends GUI
class_name TrashCanInfoDialog


@export var trash_cans: Array[TrashCanNode]


func _ready() -> void: 
	for cans: TrashCanNode in trash_cans: 
		#cans.item_accepted.connect(_on_item_accepted)
		cans.item_rejected.connect(_on_item_rejected)
	
func _on_item_rejected(_item: ItemStack) -> void: 
	set_active(true)
	
	
