extends GUI
class_name PlayerHUD

@export var inventory_gui: InventoryGUI
@export var navbar_gui: NavbarGUI
@export var quests_menu: QuestsMenu


func _ready() -> void: 
	PlayerManager.player_instanced.connect(_on_player_instanced)


func _on_player_instanced() -> void: 
	var player: PlayerNode = PlayerManager.player
	inventory_gui.inventory = player.inventory
