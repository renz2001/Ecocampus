extends NodeComponent
class_name ChangeSceneComponent

@export_file() var to_scene: String
@export var transition: GUITransition


func change() -> void: 
	SceneLoader.load_file(ChangeSceneArguments.new().set_scene(to_scene).set_transition(transition))


func set_properties(args: ChangeSceneArguments) -> void: 
	if args == null: 
		return
	to_scene = args.scene
	transition = args.transition
