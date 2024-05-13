extends NodeComponent
class_name ChangeSceneComponent

signal changing
signal changed

@export_file(".tscn") var to_scene: String
@export var transition: GUITransition
@export var middle_transition_end_condition: MiddleTransitionGUI.EndCondition = MiddleTransitionGUI.EndCondition.LOADING_FINISHED
#@export var save_on_change: bool
@export var dont_save_game_before_change: bool

# TODO: WIP
# TODO: Change to_scene form String to PackedScene then use PackedScene.resource_path
func change() -> void: 
	# BandAid solution
	changing.emit()
	if get_tree().current_scene is LevelNode: 
		# FIXME: BandAid Solution
		if !dont_save_game_before_change: 
			SaveManager.save_game()
			SaveManager.save_game_to_file(true)
		
	SceneLoader.load_file(ChangeSceneArguments.new().set_scene(to_scene).set_transition(transition).set_middle_transition_end_condition(middle_transition_end_condition))
	changed.emit()


func set_properties(args: ChangeSceneArguments) -> void: 
	if args == null: 
		return
	to_scene = args.scene
	transition = args.transition
	middle_transition_end_condition = args.middle_transition_end_condition
