extends Node2D

# --- Movement Variables ---
var direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO
var speed: float = 300.0
var acceleration: float = 1500.0
var friction: float = 2000.0
var screen_size: Vector2


func _ready() -> void:
	screen_size = get_viewport_rect().size


func _process(delta: float) -> void:
	# 1. Get Input
	direction = Vector2.ZERO
	
	if Input.is_action_pressed("left_motion"):
		direction.x -= 1
	if Input.is_action_pressed("right_motion"):
		direction.x += 1
	if Input.is_action_pressed("up_motion"):
		direction.y -= 1
	if Input.is_action_pressed("down_motion"):
		direction.y += 1
	
	# 2. Smooth Movement
	if direction.length() > 0:
		velocity = velocity.move_toward(direction.normalized() * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	position += velocity * delta
	
	# 3. Keep on screen
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
