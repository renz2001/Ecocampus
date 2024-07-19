extends Entity
class_name ItemEntity


enum Type {
	RECYCLABLE, 
	BIODEGRADABLE, 
	NON_BIODEGRADABLE, 
	TOOL
}

@export var type: Type
@export_multiline var environmental_impact: String
