
extends Node

var enemy_scene = preload("res://entities/enimies/enemy.tscn")
var blue_line_y: float = 420.0

func _ready() -> void:
	randomize()

	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.5
	timer.timeout.connect(_create_enemy)
	timer.start()

func _process(_delta: float) -> void:
	for enemy in get_parent().get_node("enimies").get_children():
		if enemy.global_position.y >= blue_line_y:
			get_tree().paused = true
			break

func _create_enemy() -> void:
	var enemy = enemy_scene.instantiate()
	var screen_width = 400

	enemy.position = Vector2(randf_range(20, screen_width - 20), -20)
	get_parent().get_node("enimies").add_child(enemy)
