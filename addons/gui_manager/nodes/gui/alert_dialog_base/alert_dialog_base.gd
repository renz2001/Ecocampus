extends DialogGUI
class_name AlertDialogBase

@export var description_label: Label

@export var yes_button: BaseButton
@export var no_button: BaseButton

var config: AlertDialogConfig


static func this() -> AlertDialogBase: 
	return GameManager.get_tree().get_first_node_in_group("AlertDialog")


static func display(args: AlertDialogConfig) -> AlertDialogBase: 
	GUIManager.set_gui_active(AlertScreen.this(), true)
	var dialog: AlertDialogBase = AlertDialogBase.this()
	#GUIManager.add_gui(dialog) 
	dialog.config = args
	dialog.description_label.text = args.description
	
	if args.yes_func != null: 
		dialog.yes_button.pressed.connect(args.yes_func, CONNECT_ONE_SHOT)
		
	if args.no_func != null: 
		dialog.no_button.pressed.connect(args.no_func, CONNECT_ONE_SHOT)
	
	if args.close_when_yes_pressed: 
		dialog.yes_button.pressed.connect(dialog.close, CONNECT_ONE_SHOT)
		
	if args.close_when_no_pressed: 
		dialog.no_button.pressed.connect(dialog.close, CONNECT_ONE_SHOT)
		
	return dialog


func close() -> void: 
	GUIManager.set_gui_active(AlertScreen.this(), false)
	var dialog: AlertDialogBase = AlertDialogBase.this() 
	dialog.disconnect_all()
	
	
func disconnect_all() -> void: 
	
	await get_tree().process_frame
	
	if is_instance_valid(config.yes_func): 
		if yes_button.pressed.is_connected(config.yes_func): 
			yes_button.pressed.disconnect(config.yes_func)
		
	if is_instance_valid(config.no_func): 
		if no_button.pressed.is_connected(config.no_func): 
			no_button.pressed.disconnect(config.no_func)

	if yes_button.pressed.is_connected(close): 
		yes_button.pressed.disconnect(close)
		
	if no_button.pressed.is_connected(close): 
		no_button.pressed.disconnect(close)
		
		
