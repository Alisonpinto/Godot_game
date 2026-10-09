
extends CharacterBody2D

@export var speed: float = 300.0
@export var screen_margin: float = 40.0
@export var fire_cooldown: float = 0.15

var bullet_scene = preload("res://entities/bullet/bullet.tscn")
var fire_timer: float = 0.0


func _process(delta: float) -> void:
	# Player movement
	var direction := Input.get_axis("move_left", "move_right")
	position.x += direction * speed * delta

	# Keep rocket inside screen
	var screen_width := get_viewport_rect().size.x
	position.x = clamp(position.x, screen_margin, screen_width - screen_margin)

	# Shooting
	fire_timer -= delta

	if Input.is_action_pressed("fire") and fire_timer <= 0.0:
		shoot()
		fire_timer = fire_cooldown


func shoot() -> void:
	var bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = global_position + Vector2(0, -35)
	print("BULLET FIRED!")
