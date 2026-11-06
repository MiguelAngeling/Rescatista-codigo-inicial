extends CharacterBody2D

@export var speed: float = 200.0
@export var bullet_scene: PackedScene
@export var monster_transformation_scene: PackedScene 

var hp: float = 100.0
var transformation_charge: float = 0.0 
var is_invulnerable: bool = false

@onready var sprite = $Sprite2D

@warning_ignore("unused_parameter")
func _physics_process(delta):
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
	move_and_slide()
	
	handle_shooting()
	
	if Input.is_action_just_pressed("activate_child") and transformation_charge >= 100.0:
		trigger_child_transformation()

func handle_shooting():
	var shoot_dir = Vector2.ZERO
	if Input.is_action_just_pressed("shoot_up"): shoot_dir = Vector2.UP
	elif Input.is_action_just_pressed("shoot_down"): shoot_dir = Vector2.DOWN
	elif Input.is_action_just_pressed("shoot_left"): shoot_dir = Vector2.LEFT
	elif Input.is_action_just_pressed("shoot_right"): shoot_dir = Vector2.RIGHT
		
	if shoot_dir != Vector2.ZERO:
		fire_bullet(shoot_dir)

func fire_bullet(dir: Vector2):
	if bullet_scene:
		var bullet = bullet_scene.instantiate()
		bullet.global_position = global_position
		bullet.direction = dir
		get_tree().current_scene.add_child(bullet)

func trigger_child_transformation():
	transformation_charge = 0.0 
	is_invulnerable = true
	
	if monster_transformation_scene:
		var monster = monster_transformation_scene.instantiate()
		monster.duration = 6.0 
		add_child(monster) 
		
	await get_tree().create_timer(6.0).timeout
	is_invulnerable = false

func take_damage(amount: float):
	if is_invulnerable:
		return
		
	hp -= amount
	transformation_charge = min(100.0, transformation_charge + 20.0)
	print("Vida actual de Jenny: ", hp, " | Carga de 4NG3L: ", transformation_charge, "%")
	
	if hp <= 0:
		die()

func die():
	print("Game Over")
	get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")
