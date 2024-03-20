extends OnPressedComponent
class_name ScrollSnapController

enum ScrollType {
	NEXT, 
	BACK
}

@export var scroll_snap_container: ScrollSnapContainer
@export var scroll_type: ScrollType


func _on_pressed() -> void: 
	match scroll_type: 
		ScrollType.NEXT: 
			scroll_snap_container.next()
		ScrollType.BACK: 
			scroll_snap_container.back()
	
	
