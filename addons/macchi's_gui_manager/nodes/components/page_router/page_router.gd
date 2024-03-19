@tool
extends NodeComponent
class_name PageRouter

enum RouteType {
	GO_AT, 
	BACK, 
	NEXT_INDEX, 
}

@export var page_router_container: PageRouterContainer
@export var route_type: RouteType
@export var button: BaseButton: 
	set(value): 
		button = value
		if button: 
			button.pressed.connect(_on_pressed)
			
@export var go_at: Control


func route() -> void: 
	match route_type: 
		RouteType.GO_AT: 
			page_router_container.go_at(go_at)
		RouteType.BACK: 
			page_router_container.back() 
		RouteType.NEXT_INDEX: 
			if page_router_container.current_tab >= page_router_container.get_child_count(): 
				page_router_container.go_at(go_at)
				return
			page_router_container.go_at_next_index()
			
			
func _on_pressed() -> void: 
	route()
	
	
