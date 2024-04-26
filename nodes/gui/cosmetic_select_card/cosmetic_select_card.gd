@tool
extends GUI
class_name CosmeticSelectCard

@export var player: Player
@export var cosmetics_collection: CosmeticsCollection: 
	set(value): 
		cosmetics_collection = value
		if !is_node_ready(): 
			await ready
		cosmetics_display_container.cosmetics_collection = cosmetics_collection


@export var player_gender_label: Label
@export var scroll_snap_container: ScrollSnapContainer
@export var cosmetics_display_container: CosmeticsDisplayCardContainer
@export var equip_cosmetic_button: EquipCosmeticButton

var current_cosmetic: Cosmetic: 
	get: 
		if !is_node_ready(): 
			await ready
		var card: CosmeticDisplayCard = cosmetics_display_container.get_visible_card_at(scroll_snap_container.current_snap_index)
		if card == null: 
			return null
		return card.cosmetic


func _ready() -> void: 
	update()
	player.gender_changed.connect(update)
	scroll_snap_container.finished_snap.connect(_on_scroll_snap_finished_snap)


func _on_scroll_snap_finished_snap() -> void: 
	if !Engine.is_editor_hint() && PlayerManager.player:
		update()


func update() -> void: 
	player_gender_label.text = GlobalVariables.get_enum_name(GlobalEnums.Gender, player.gender)
	# FIXME
	if current_cosmetic: 
		equip_cosmetic_button.cosmetic = current_cosmetic



func _on_cosmetics_display_card_container_updated() -> void:
	update()
