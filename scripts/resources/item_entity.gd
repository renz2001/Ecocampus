extends Entity
class_name ItemEntity


enum Type {
	RECYCLABLE, 
	BIODEGRADABLE, 
	NON_BIODEGRADABLE
}

@export var type: Type
