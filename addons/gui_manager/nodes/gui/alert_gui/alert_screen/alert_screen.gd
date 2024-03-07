extends GUI
class_name AlertScreen

@onready var alert_box: AlertBox = $Background/CenterContainer/AlertBox
@onready var alert_label: Label = alert_box.alert_label
@onready var no: Button = alert_box.no
@onready var yes: Button = alert_box.yes
