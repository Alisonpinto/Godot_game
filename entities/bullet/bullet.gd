
extends Area2D

@export var speed: float = 900.0
@export var lifetime: float = 2.0

var life_timer: float = 0.0


func _ready() -> void:
	life_timer = lifetime

	# Bullet belongs to the bullet group.
	add_to_group("player_bullet")

	# Collision setup.
	collision_layer = 2
	collision_mask = 1

	# Allow collision detection.
	monitoring = true
	monitorable = true

	# Listen for enemy collision.
	area_entered.connect(_on_area_entered)


func _physics_process(delta: float) -> void:
	# Move upward.
	global_position.y -= speed * delta

	# Lifetime.
	life_timer -= delta

	if life_timer <= 0.0:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	print("BULLET HIT: ", area.name)

	if area.is_in_group("enemy"):
		# Damage the enemy.
		area.take_damage()

		# Remove the bullet.
		queue_free()
