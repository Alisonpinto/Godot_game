
extends Area2D

@export var speed: float = 120.0
@export var health: int = 1


func _ready() -> void:
	add_to_group("enemy")

	collision_layer = 1
	collision_mask = 2

	monitoring = true
	monitorable = true

	area_entered.connect(_on_area_entered)


func _physics_process(delta: float) -> void:
	global_position.y += speed * delta

	if global_position.y > get_viewport_rect().size.y + 100.0:
		queue_free()


func take_damage(amount: int = 1) -> void:
	health -= amount
	print("ENEMY HIT! Health: ", health)

	if health <= 0:
		destroy()



func destroy() -> void:
	print("ENEMY DESTROYED!")

	var node: Node = self

	while node != null and node.name != "GameManager":
		node = node.get_parent()

	if node != null:
		node.add_score(1)
		print("Score increased!")
	else:
		print("ERROR: GameManager not found in parent hierarchy!")

	queue_free()



func _on_area_entered(area: Area2D) -> void:
	if area.name == "BulletArea":
		area.get_parent().queue_free()
		destroy()
