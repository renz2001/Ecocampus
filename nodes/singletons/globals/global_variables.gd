extends Node

enum Directions {
	DOWN, 
	LEFT, 
	UP, 
	RIGHT
}

enum ScreenSizes {
	CURRENT, 
	INITIAL, 
	FOUR_THREE
}

enum AudioBusses {
	MASTER, 
	JUMP_SCARE_SFX, 
	ENTITY_SFX, 
	MAIN_MENU_MUSIC, 
	AMBIENCE, 
	ENVIRONMENT, 
	BACKGROUND_MUSIC, 
	SFX, 
}

const COLOR_EDITOR_RED = Color("ff7085")
const COLOR_EDITOR_YELLOW = Color("fbe99f")
const COLOR_EDITOR_GREEN = Color("42ffc2")
const COLOR_ICON_BLUE = Color("6393ff")

const screenshots: String = "user://screenshots/"

const UNIT_SIZE: int = 64 

const BASE_SPEED: float = 1
## This is mainly use so that i can scale it with the AnimationPlayer speed
## Also called as the default speed for all characters
## 5 (entity scaled_move_speed) / SCALED_BASE_SPEED
const SCALED_BASE_SPEED: float = BASE_SPEED * UNIT_SIZE

var viewport_size: Vector2: 
	get: 
		return get_viewport().get_visible_rect().size
		
var initial_viewport_size: Vector2 = Vector2(ProjectSettings.get_setting_with_override("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"))

var screen_sizes: Dictionary: 
	get: 
		return {
			0: viewport_size, 
			1: initial_viewport_size, 
			2: Vector2(640, 480)
		}

func get_tile_scaled_speed(speed: float) -> float: 
	return speed * UNIT_SIZE


func get_screen_size_value(val: ScreenSizes) -> Vector2: 
	if !screen_sizes.has(val): 
		push_error("EditorGlobals: The specified screen size value does not exist. ")
		return Vector2.ZERO
	return screen_sizes[val]
	

#func get_audio_bus_name(bus: AudioBussses) -> String: 
	#return AudioBusses.keys()[]
	#
	
func get_enum_name(en, value) -> String: 
	return en.keys()[value]
	
	
	
