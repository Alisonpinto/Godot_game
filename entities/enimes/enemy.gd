extends Area2D

@export var speed: float = 120.0
@export var health: int = 1


func _ready() -> void:

	# Add enemy to the enemy group.
	add_to_group("enemy")

	# Collision setup.
	collision_layer = 1
	collision_mask = 2

	# Allow other areas to detect this enemy.
	monitoring = true
	monitorable = true


func _physics_process(delta: float) -> void:

	# Move downward.
	global_position.y += speed * delta

	# Delete enemy when it leaves the screen.
	if global_position.y > get_viewport_rect().size.y + 100.0:
		queue_free()


func take_damage(amount: int = 1) -> void:

	health -= amount

	print("ENEMY HIT! Health: ", health)

	if health <= 0:
		destroy()


func destroy() -> void:

	print("ENEMY DESTROYED!")

	queue_free()
