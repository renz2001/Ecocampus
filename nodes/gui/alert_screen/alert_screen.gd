extends GUI
class_name AlertScreen


static func this() -> AlertScreen: 
	return GameManager.get_tree().get_first_node_in_group("AlertScreen")
