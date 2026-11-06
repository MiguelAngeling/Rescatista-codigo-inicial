extends CanvasLayer

@onready var health_bar = $HealthBar
@onready var transformation_bar = $TransformationBar

@warning_ignore("unused_parameter")
func _process(delta):
	var player = get_tree().get_first_node_in_group("player")
	if player:
		health_bar.value = player.hp
		transformation_bar.value = player.transformation_charge
