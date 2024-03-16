extends Node

signal load_started
signal thread_load_loaded
signal load_ended 

@export var _print_color: PrintColor: 
	set(value): 
		_print_color = value
		_print_color.owner = self

var has_thread_load_loaded: bool
var _next_scene_path: String
var load_status: ResourceLoader.ThreadLoadStatus
var load_progress: Array

#var _loaded_scene
#@onready var load_screen: LoadScreen = GUIManager.load_screen


func _init() -> void: 
	set_process.call_deferred(false)


func _process(_delta: float) -> void: 
	#var current_scene: Node = get_tree().current_scene
	#load_screen.load_progress = load_progress
	load_status = ResourceLoader.load_threaded_get_status(_next_scene_path, load_progress)
	#printerr(load_status)
	match load_status: 
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_INVALID_RESOURCE: 
			set_process(false)
			push_error("Error: Cannot load scene, resource is invalid.")
			load_ended.emit()
		# For loading screens with progress bars
#			ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS:
#				load_screen.get_node("Control/ProgressBar").value = load_progress[0]
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_FAILED:
			set_process(false)
			push_error("Error: Loading failed!")
			load_ended.emit()
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
			set_process(false)
			has_thread_load_loaded = true
			thread_load_loaded.emit()
			var next_scene: PackedScene = ResourceLoader.load_threaded_get(_next_scene_path)
			if GUIManager.transitions_manager.transitioning: 
				await GUIManager.transitions_manager.middle_transition.ended
			get_tree().change_scene_to_packed(next_scene)
			_print_color.out_debug_wvalue("Loading scene finished", _next_scene_path)
			load_ended.emit()
			has_thread_load_loaded = false
			#print_orphan_nodes()


func load_file(args: ChangeSceneArguments) -> void:
	_next_scene_path = args.scene
	if !ResourceLoader.exists(_next_scene_path): 
		push_error("Error: Attempting to load non-existent file: %s" % _next_scene_path)
		return
	
	GUIManager.transitions_manager.prepare_transition(args.transition)
	GUIManager.transitions_manager.start(args.transition, MiddleTransitionGUI.EndCondition.LOADING_FINISHED)
	
	ResourceLoader.load_threaded_request(_next_scene_path)
	_print_color.out_debug_wvalue("Started loading scene", _next_scene_path)
	set_process(true)
	load_started.emit()


#func change_scene() -> void: 
	#pass
	#
	
