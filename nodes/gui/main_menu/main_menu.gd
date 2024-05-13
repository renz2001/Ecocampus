extends MainScreen
class_name MainMenu

@export var print_color: PrintColor: 
	set(value): 
		print_color = value
		print_color.owner = self


func _ready() -> void:
	super._ready()
	BackManager.history.data.clear()
	print_color.out_debug_wvalue("Does have save?", SaveManager.does_save_file_name_exists("save_file_1"))
