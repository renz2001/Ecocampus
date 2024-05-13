extends NodeComponent
class_name BackRequest


func _notification(what: int) -> void: 
	if what == NOTIFICATION_WM_GO_BACK_REQUEST: 
		BackManager.back()
