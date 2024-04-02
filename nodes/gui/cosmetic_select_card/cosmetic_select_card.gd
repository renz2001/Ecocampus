@tool
extends GUI
class_name CosmeticSelectCard


@export var cosmetics_collection: CosmeticsCollection: 
	set(value): 
		cosmetics_collection = value
		if !is_node_ready(): 
			await ready
		cosmetics_display_container.cosmetics_collection = cosmetics_collection


@export var player_gender_label: Label
@export var scroll_snap_container: ScrollSnapContainer
@export var cosmetics_display_container: CosmeticsDisplayCardContainer


var current_cosmetic: Cosmetic: 
	get: 
		return cosmetics_collection.cosmetics[scroll_snap_container.current_snap_index]


func _ready() -> void: 
	if !Engine.is_editor_hint() && PlayerManager.player:
		player_gender_label.text = GlobalVariables.get_enum_name(GlobalEnums.Gender, GroupNodeFetcher.get_player().gender)
	scroll_snap_container.finished_snap.connect(_on_scroll_snap_finished_snap)


func _on_scroll_snap_finished_snap() -> void: 
	if !Engine.is_editor_hint() && PlayerManager.player:
		var player: PlayerNode = PlayerManager.player
		player.cosmetic_equipper_component.current_cosmetic = current_cosmetic
		# FIXME
		#player.data.speaker_sprite = current_cosmetic.get_icon(player.gender)

