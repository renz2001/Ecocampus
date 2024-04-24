extends NodeComponent
class_name ChangeSceneComponent

@export_file(".tscn") var to_scene: String
@export var transition: GUITransition

# TODO: WIP
func change() -> void: 
	SaveManager.save_game()
	SaveManager.save_game_to_file(true)
	SceneLoader.load_file(ChangeSceneArguments.new().set_scene(to_scene).set_transition(transition))


func set_properties(args: ChangeSceneArguments) -> void: 
	if args == null: 
		return
	to_scene = args.scene
	transition = args.transition
