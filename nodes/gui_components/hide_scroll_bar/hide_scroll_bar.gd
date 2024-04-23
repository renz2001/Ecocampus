@tool
extends NodeComponent
class_name HideScrollBar

@export var scroll_container: ScrollContainer

@export var hide_h_scroll_bar: bool: 
	set(value): 
		hide_h_scroll_bar = value
		if !scroll_container.is_node_ready(): 
			await scroll_container.ready
		if hide_h_scroll_bar: 
			add_scroll_stylebox_override(scroll_container.get_h_scroll_bar(), empty_stylebox)
		else: 
			add_scroll_stylebox_override(scroll_container.get_h_scroll_bar(), null)

var empty_stylebox = StyleBoxEmpty.new()


func add_scroll_stylebox_override(scroll_bar: ScrollBar, stylebox: StyleBox) -> void: 
	scroll_bar.add_theme_stylebox_override("scroll", stylebox)
	scroll_bar.add_theme_stylebox_override("scroll_focus", stylebox)
	scroll_bar.add_theme_stylebox_override("grabber", stylebox)
	scroll_bar.add_theme_stylebox_override("grabber_highlight", stylebox)
	scroll_bar.add_theme_stylebox_override("grabber_pressed", stylebox)

