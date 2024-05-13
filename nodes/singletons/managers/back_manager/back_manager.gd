extends Node

@export var change_scene: ChangeSceneComponent
@export var cooldown: Timer
@export var print_color: PrintColor: 
	set(value): 
		print_color = value
		print_color.owner = self

var history: History = History.new() 


#func _ready() -> void: 
	#SceneLoader.load_ended.connect(_on_load_ended)
	
	
#func _on_load_ended(path: String) -> void: 
	#history.add(path)
	#
	
func add(value) -> void: 
	if !history.data.is_empty(): 
		if value is String && history.data.back() is String: 
			if value == history.data.back():
				return
		elif value is Object && history.data.back() is Object: 
			if value == history.data.back():
				return
				
				
	history.add(value)
	print_color.out_debug_wvalue("Added to history", value)
	print_color.out_debug_wvalue("Current history", history.data)
	
	
func back() -> void: 
	if !cooldown.wait_time > 0: 
		return
		
	for value in history.data: 
		if !is_instance_valid(value) && !value is String && !value is StringName: 
			history.data.erase(value)
			print_color.out_debug_wvalue("Deleted since it is not in memory", value)
		
	cooldown.start()
	var last = history.back()
	
	#if ResourceLoader.exists(last): 
		#last = history.back() 
		
	if last == null: 
		return
	
	
	if last is String && ResourceLoader.exists(last): 
		change_scene.to_scene = last
		change_scene.change()
	elif last is GUI: 
		GUIManager.set_gui_active(last, false)
		
	print_color.out_debug_wvalue("Backed", last)
	print_color.out_debug_wvalue("Current history", history.data)
	
