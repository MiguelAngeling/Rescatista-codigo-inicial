extends Area2D

@export var speed: float = 400.0
var direction: Vector2 = Vector2.ZERO
var damage: float = 10.0 

func _physics_process(delta):
	global_position += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("enemies") and body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free() 
	elif body.is_in_group("walls") or body.name == "Walls":
		queue_free()
