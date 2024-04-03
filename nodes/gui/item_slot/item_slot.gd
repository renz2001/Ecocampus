@tool
extends TextureButtonPlus
class_name ItemSlot

@export var stack_label: Label
@export var item_texture_rect: TextureRect

@export var item: Item: 
	set(value): 
		item = value
		if !is_node_ready(): 
			await ready
		if Engine.is_editor_hint(): 
			if item: 
				item_texture_rect.texture = item.item_icon
			
		if item == null: 
			_display_empty()
		elif item.stack.current > 0: 
			# FIXME: Stack label doesn't show even if it says show. 
			stack_label.text = stack_label_preset % str(item.stack.current)
			if item.stack.current > 1: 
				stack_label.show()
				#print(self)
				#print(stack_label.visible)
			else: 
				stack_label.hide()
			item_texture_rect.texture = item.item_icon
		else: 
			_display_empty()

var stack_label_preset: String = "x%s"


func _display_empty() -> void: 
	item_texture_rect.texture = null
	stack_label.hide()
	#printerr(self)
	#printerr(stack_label.visible)

