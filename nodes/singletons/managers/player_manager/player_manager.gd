@tool
extends Node

signal player_instanced

var player: PlayerNode: 
	get: 
		return GroupNodeFetcher.get_player()
