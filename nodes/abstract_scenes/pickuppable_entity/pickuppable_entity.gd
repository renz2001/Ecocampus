extends EntityNode
class_name PickuppableEntity

# TODO: Implement entity being queued free if it is queued free from previous save. 

func _ready() -> void: 
	super._ready() 
	interact_description = RichLabelText.new()
	
	interact_description.format = StringFormatter.new()
	
	interact_description.format.format = \
"[outline_size=4][outline_color=BLACK][b][font_size=38]%s[/font_size][/b]
[font_size=28][b]Type:[/b] %s[/font_size]
[font_size=28][b]Environmental Impact:[/b] %s[/font_size]"
	
	interact_description.texts = [
		data.name, 
		GlobalVariables.get_enum_name(ItemEntity.Type, data.type).to_pascal_case(), 
		inventory.items[0].model.description
	] as Array[String]

