@tool
extends Node
class_name BaseGlobalVariables

const COLOR_EDITOR_LIGHT_GREEN = Color("bef5e5")
const COLOR_EDITOR_RED = Color("ff7085")
const COLOR_EDITOR_YELLOW = Color("fbe99f")
const COLOR_EDITOR_GREEN = Color("42ffc2")
const COLOR_ICON_BLUE = Color("6393ff")

#const screenshots: String = "user://screenshots/"

@export var UNIT_SIZE: int = 64

@export var BASE_SPEED: float = 1

## This is mainly use so that i can scale it with the AnimationPlayer speed
## Also called as the default speed for all characters
## 5 (entity scaled_move_speed) / SCALED_BASE_SPEED

var SCALED_BASE_SPEED: float = BASE_SPEED * UNIT_SIZE

var viewport_size: Vector2: 
	get: 
		return get_viewport().get_visible_rect().size
		
var initial_viewport_size: Vector2 = Vector2(ProjectSettings.get_setting_with_override("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"))

var expanded_viewport_percentage: Vector2: 
	get: 
		return viewport_size / initial_viewport_size


var screen_sizes: Dictionary: 
	get: 
		return {
			0: viewport_size, 
			1: initial_viewport_size, 
			2: Vector2(640, 480)
		}

func get_tile_scaled_speed(speed: float) -> float: 
	return speed * UNIT_SIZE


func get_screen_size_value(val: BaseGlobalEnums.ScreenSizes) -> Vector2: 
	if !screen_sizes.has(val): 
		push_error("EditorGlobals: The specified screen size value does not exist. ")
		return Vector2.ZERO
	return screen_sizes[val]
	

#func get_audio_bus_name(bus: AudioBussses) -> String: 
	#return AudioBusses.keys()[]
	#
	
func get_enum_name(en, value) -> String: 
	return en.keys()[value]
	
	
func get_direction_vector(dir: BaseGlobalEnums.Directions) -> Vector2: 
	match dir: 
		BaseGlobalEnums.Directions.DOWN:
			return Vector2.DOWN
		BaseGlobalEnums.Directions.LEFT: 
			return Vector2.LEFT
		BaseGlobalEnums.Directions.UP:
			return Vector2.UP
		BaseGlobalEnums.Directions.RIGHT:
			return Vector2.RIGHT
		BaseGlobalEnums.Directions.NEUTRAL: 
			return Vector2.ZERO
	return Vector2.ZERO

