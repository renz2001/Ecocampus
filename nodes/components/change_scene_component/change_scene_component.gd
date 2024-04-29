extends NodeComponent
class_name ChangeSceneComponent

@export_file(".tscn") var to_scene: String
@export var transition: GUITransition
#@export var save_on_change: bool

# TODO: WIP
# TODO: Change to_scene form String to PackedScene then use PackedScene.resource_path
func change() -> void: 
	# BandAid solution
	if get_tree().current_scene is LevelNode: 
		SaveManager.save_game()
		SaveManager.save_game_to_file(true)
		
	SceneLoader.load_file(ChangeSceneArguments.new().set_scene(to_scene).set_transition(transition))


func set_properties(args: ChangeSceneArguments) -> void: 
	if args == null: 
		return
	to_scene = args.scene
	transition = args.transition
