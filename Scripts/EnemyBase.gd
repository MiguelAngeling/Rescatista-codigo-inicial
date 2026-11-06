extends CharacterBody2D

@export var hp: float = 30.0
@export var speed: float = 100.0
@export var damage: float = 5.0

func _ready():
	add_to_group("enemies")

func _physics_process(delta):
	var player = get_tree().get_first_node_in_group("player")
	if player:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()

func take_damage(amount: float):
	hp -= amount
	print("Enemigo recibió daño. HP restante: ", hp)
	if hp <= 0:
		die()

func die():
	queue_free()
