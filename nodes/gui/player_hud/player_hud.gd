extends GUI
class_name PlayerHUD

@export var inventory_gui: InventoryGUI
@export var tools_item_slot: ToolsItemSlot


func _ready() -> void: 
	PlayerManager.player_instanced.connect(_on_player_instanced)


func _on_player_instanced() -> void: 
	var player: PlayerNode = PlayerManager.player
	inventory_gui.inventory = player.data.inventory
	tools_item_slot.inventory = player.data.inventory
