@tool
extends GUI
class_name DialogueGUIManager

# Need to make it so that the dialogue can be paused. 

signal dialogue_paused
signal dialogue_unpaused

@export var dialogue_guis: TabContainer

@export var current_dialogue_gui: DialogueGUI: 
	set(new_dialogue_gui):
		#var previous_dialogue_gui: DialogueGUI = current_dialogue_gui
		current_dialogue_gui = new_dialogue_gui
		if is_instance_valid(current_dialogue_gui.acting_container): 
			dialogue_guis.current_tab = get_index_from_tab(current_dialogue_gui.acting_container) 
		else: 
			dialogue_guis.current_tab = get_index_from_tab(current_dialogue_gui)



#@export var _print_color: PrintColor

var will_hide_balloon: bool: 
	set(value): 
		will_hide_balloon = value
		current_dialogue_gui.will_hide_balloon = will_hide_balloon
		
var dialogue_manager: DialogueManager: 
	get: 
		return DialogueManager


#var paused: bool = false:
	#set(value):
		#paused = value
		#if paused:
			#dialogue_paused.emit()
		#else: 
			#dialogue_unpaused.emit()
			

## The current line
## If the next id is blank, it will start at the beginning
var dialogue_line: DialogueLine:
	set(next_dialogue_line):
		#await get_tree().process_frame
		#if stopped: 
			#return
			
		dialogue_line = next_dialogue_line
		current_dialogue_gui.dialogue_line = dialogue_line


#@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
#@onready var dialogue_guis: Array[DialogueGUI] = [
	#title_card, 
	#dialogue_box
#]

@export var text_speed_multiplier: float = 5

var _current_arguments: DialogueArguments

func _ready() -> void: 
	if Engine.is_editor_hint(): 
		return
	DialogueManager.mutated.connect(_on_mutated)


func _unhandled_input(_event: InputEvent) -> void:
	# Only the current_dialogue_gui is allowed to handle input while it's showing
	get_viewport().set_input_as_handled()


func get_index_from_tab(node: Control) -> int: 
	return dialogue_guis.get_children().find(node)


## Start some dialogue
# No longer can be used just by anything, it needs a counter as an argument. Recommended to be used with DialogueStarter Component
func start(arguments: DialogueArguments, title_variation_counter: PointCounterComponent) -> void: 
	_current_arguments = arguments
	GUIManager.set_gui_active(self, true)
	will_hide_balloon = true
	arguments.add_extra_game_states([self])
	set_dialogue_gui_by_alias(arguments.dialogue_gui)
	current_dialogue_gui.start(arguments, title_variation_counter)

#func speed_up_text(text: String) -> String: 
	#var seperate_bbcode: PackedStringArray = text.split("[")
	##printerr()
	#for i: int in seperate_bbcode.size(): 
		#var word: String = seperate_bbcode[i]
		#var new_word: String = word
		#if word.contains("speed"): 
			#var speed: float = word.to_float() 
			#var keyword: String = word.substr(0, 5)
			#speed *= text_speed_multiplier
			#new_word = keyword + str(speed)
		#new_word = "[%s]" % new_word
		#seperate_bbcode[i] = new_word
		#continue
	#var new_text: String = "".join(seperate_bbcode)
	##print(new_text)
	#return new_text


#func split(s: String, delimeters, allow_empty: bool = true) -> Array:
	#var parts := []
	#
	#var start := 0
	#var i := 0
	#
	#while i < s.length():
		#if s[i] in delimeters:
			#if allow_empty or start < i:
				#parts.push_back(s.substr(start, i - start))
			#start = i + 1
		#i += 1
	#
	#if allow_empty or start < i:
		#parts.push_back(s.substr(start, i - start))
	#
	#return parts
	
	
func set_dialogue_gui_active(value: bool) -> void:
	current_dialogue_gui.character_label.visible = value
	current_dialogue_gui.responses_menu.visible = value
	current_dialogue_gui.dialogue_label.visible = value
	#if value: 
		#stop(value) 	
	#dialogue_container_input_disabled = !value
	#if value == true:
		#next(dialogue_line.next_id)
	
	
func set_dialogue_gui_by_name(balloon_name: String) -> void: 
	for node: DialogueGUI in get_tree().get_nodes_in_group("DialogueGUI"): 
		#print(DialogueGUI.DialogueGUIAlias.keys()[node.dialogue_gui_alias])
		if DialogueGUI.DialogueGUIAlias.keys()[node.dialogue_gui_alias].to_snake_case().to_upper() == balloon_name.to_snake_case().to_upper(): 
			node.will_hide_balloon = current_dialogue_gui.will_hide_balloon
			node.resource = current_dialogue_gui.resource
			node.dialogue_line = current_dialogue_gui.dialogue_line
			current_dialogue_gui = node
			return
	push_error("DialogueGUIManager: dialogue balloon not found. ")
	
	
func set_dialogue_gui_by_alias(_alias: DialogueGUI.DialogueGUIAlias) -> void: 
	if _alias == DialogueGUI.DialogueGUIAlias.RETAIN_LAST_DIALOGUE: 
		return
	for node in get_tree().get_nodes_in_group("DialogueGUI"): 
		if node.dialogue_gui_alias == _alias: 
			node.will_hide_balloon = current_dialogue_gui.will_hide_balloon
			node.resource = current_dialogue_gui.resource
			node.dialogue_line = current_dialogue_gui.dialogue_line
			current_dialogue_gui = node
			return
	push_error("DialogueGUIManager: dialogue balloon not found. ")
	
	
func set_dialogue_gui(balloon: DialogueGUI) -> void: 
	current_dialogue_gui = balloon
	
	
### Signals
func _on_mutated(_mutation: Dictionary) -> void:
	#print(_mutation)
	current_dialogue_gui.is_waiting_for_input = false
	#will_hide_balloon = true
	#get_tree().create_timer(0.1).timeout.connect(func():
		#if will_hide_balloon:
			#will_hide_balloon = false
			#current_dialogue_gui.hide()
	#)







