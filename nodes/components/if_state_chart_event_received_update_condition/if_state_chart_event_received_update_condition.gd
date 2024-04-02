extends ConditionalSetPropertyComponent
class_name IfStateChartEventReceivedUpdateCondition

func _ready() -> void: 
	super._ready()
	update_condition()
	GameManager.state_chart.event_received.connect(
		func(_event: String): 
			var current_scene: Node = get_tree().current_scene
			if !current_scene.is_node_ready(): 
				await current_scene.ready
			get_tree().physics_frame.connect(
				func(): 
					update_condition()
			, CONNECT_ONE_SHOT
			)
	)
