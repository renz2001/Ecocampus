@tool
extends NodeComponent

@export var node: Node
@export var property: String
@export var player: PlayerNode


func _ready() -> void: 
	#if !Engine.is_editor_hint(): 
		#return 
	if node != null: 
		node.set(property, PlayerManager.player)
