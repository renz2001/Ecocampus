extends TabContainer
class_name PageRouterContainer 

signal page_changed(to: Control)
signal page_back(page: Control)

@export var parent_page_router_container: PageRouterContainer
@export var back_notification: bool = true
@export var back_key: String = "ui_cancel"

var route: Array[Control]


func _notification(what: int) -> void: 
	if back_notification && what == NOTIFICATION_WM_GO_BACK_REQUEST: 
		back()
		
		
func _unhandled_input(event: InputEvent) -> void: 
	if event.is_action_pressed(back_key): 
		back()
	

func back() -> void: 
	var page: Control = route.pop_back()
	current_tab = find(page)
	page_back.emit(page)
	page_changed.emit(page)
	
	
func go_at(node: Control) -> void: 
	if node is ActingContainer: 
		current_tab = find(node.real_control)
	else: 
		current_tab = find(node)
	page_changed.emit(node)
	route.append(node)
	
	
func go_at_next_index() -> void: 
	if current_tab + 1 >= get_child_count(): 
		parent_page_router_container.go_at_next_index()
		return
	current_tab += 1
	
	
func find(node: Control) -> int: 
	return get_children().find(node)
	
	
