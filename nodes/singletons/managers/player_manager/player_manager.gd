@tool
extends Node

signal player_instanced

@export var player_data: Player: 
	set(value): 
		player_data = value
		if !is_node_ready(): 
			await ready
		if player: 
			player.data = player_data

var player: PlayerNode: 
	get: 
		return GroupNodeFetcher.get_player()
