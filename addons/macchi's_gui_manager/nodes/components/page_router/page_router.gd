@tool
extends NodeComponent
class_name PageRouter

enum RouteType {
	GO_AT, 
	BACK
}

@export var page_router_container: PageRouterContainer
@export var route_type: RouteType
@export var button: Button: 
	set(value): 
		button = value
		if button: 
			button.pressed.connect(_on_pressed)


func _on_pressed() -> void: 
	match route_type: 
		RouteType.GO_AT: 
			page_router_container.go_at(button)
		RouteType.BACK: 
			page_router_container.back() 
	
	
