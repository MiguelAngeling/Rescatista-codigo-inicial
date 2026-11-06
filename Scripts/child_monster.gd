extends Area2D

@export var duration: float = 6.0
@export var damage_per_second: float = 30.0

func _ready():
	get_tree().create_timer(duration).timeout.connect(queue_free)

func _physics_process(delta):
	var overlapping_bodies = get_overlapping_bodies()
	for body in overlapping_bodies:
		if body.is_in_group("enemies") and body.has_method("take_damage"):
			body.take_damage(damage_per_second * delta)
