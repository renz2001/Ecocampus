@icon("res://addons/easy_rpg_maker/class_icons/points-counter.png")
extends NodeComponent
class_name PointCounterComponent

@export var points: PointCounter


func set_properties(props: PointCounterProperties) -> void: 
	points.starting_value = props.starting_value
	points.maximum = props.maximum
	points.minimum = props.minimum
