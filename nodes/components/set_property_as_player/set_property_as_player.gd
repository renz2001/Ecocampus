@tool
extends NodeComponent

@export var node: Node
@export var property: String


func _ready() -> void: 
	#if !Engine.is_editor_hint(): 
		#return 
	if node != null: 
		node.set(property, PlayerManager.player)
