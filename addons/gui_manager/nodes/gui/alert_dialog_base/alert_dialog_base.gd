extends DialogGUI
class_name AlertDialogBase

@export var description_label: Label

@export var yes_button: BaseButton
@export var no_button: BaseButton


static func display(args: AlertDialogConfig) -> AlertDialogBase: 
	var dialog: AlertDialogBase = GUICollection.alert_dialog.instantiate()
	GUIManager.add_gui(dialog) 
	dialog.description_label.text = args.description
	dialog.yes_button.pressed.connect(args.yes_func)
	dialog.no_button.pressed.connect(args.no_func)
	
	if args.close_when_yes_pressed: 
		dialog.yes_button.pressed.connect(close)
		
	if args.close_when_no_pressed: 
		dialog.no_button.pressed.connect(close)
		
	return dialog


func close() -> void: 
	GUIManager.remove_gui(self) 
	
	
