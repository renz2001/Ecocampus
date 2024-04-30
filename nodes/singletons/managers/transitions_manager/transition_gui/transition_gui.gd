## Abstract Scene for transition related GUIs
@tool
extends GUI
class_name TransitionGUI

signal started
signal ended

@export var multiple_signals_listener: MultipleSignalsListener
@export var animation_player: AnimationPlayer

func play() -> void: 
	await get_tree().process_frame
	GUIManager.set_gui_active(self, true)
	if animation_player: 
		animation_player.play("default") 
	for node in multiple_signals_listener.children_nodes.get_children(): 
		if node is BaseLerpComponent: 
			node.play()
	_play()
	started.emit()
	
	
# Virtual Function
func _play() -> void: 
	pass
	
	
func end() -> void: 
	GUIManager.set_gui_active(self, false)
	ended.emit()


func _deactivated() -> void: 
	queue_free()


func _on_animations_listener_all_conditions_met() -> void:
	end()
