extends Node

@export var scientist_scene: PackedScene
@export var soldier_scene: PackedScene
@export var monster_scene: PackedScene

var current_wave: int = 0
var total_waves: int = 4

func _ready():
	start_next_wave()

func start_next_wave():
	current_wave += 1
	if current_wave > total_waves:
		trigger_victory()
		return
		
	print("--- INICIANDO OLEADA: ", current_wave, " ---")
	spawn_wave_enemies(current_wave)

func spawn_wave_enemies(wave: int):
	match wave:
		1:
			spawn_enemy(scientist_scene, Vector2(200, 200))
			spawn_enemy(scientist_scene, Vector2(400, 200))
		2:
			spawn_enemy(soldier_scene, Vector2(300, 150))
			spawn_enemy(scientist_scene, Vector2(500, 300))
		3:
			spawn_enemy(soldier_scene, Vector2(200, 300))
			spawn_enemy(monster_scene, Vector2(400, 400))
		4:
			spawn_enemy(monster_scene, Vector2(300, 200))
			spawn_enemy(soldier_scene, Vector2(500, 200))
			spawn_enemy(scientist_scene, Vector2(400, 350))

func spawn_enemy(scene: PackedScene, pos: Vector2):
	if scene:
		var enemy = scene.instantiate()
		enemy.global_position = pos
		get_tree().current_scene.add_child(enemy)

@warning_ignore("unused_parameter")
func _process(delta):
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies.size() == 0 and current_wave <= total_waves:
		await get_tree().create_timer(1.5).timeout
		start_next_wave()

func trigger_victory():
	print("¡Victoria! Misión cumplida.")
	get_tree().change_scene_to_file("res://Scenes/Victory.tscn")
