extends CharacterBody2D


# ============================================================
# PLAYER MOVEMENT
# ============================================================

@export_category("Movement")

# Distance travelled for ONE key press.
@export var tile_size: float = 80.0

# How quickly the ship slides to the next tile.
@export var slide_speed: float = 700.0

# Distance from the screen edge.
@export var screen_margin: float = 40.0


# ============================================================
# SHOOTING
# ============================================================

@export_category("Shooting")

# How often the ship can fire.
@export var fire_cooldown: float = 0.15


# ============================================================
# INTERNAL STATE
# ============================================================

var target_position: Vector2
var fire_timer: float = 0.0

# Load the bullet scene.
var bullet_scene = preload("res://entities/bullet/bullet.tscn")


# ============================================================
# READY
# ============================================================

func _ready() -> void:

	# Start exactly where the ship currently is.
	target_position = global_position


# ============================================================
# PHYSICS
# ============================================================

func _physics_process(delta: float) -> void:

	# --------------------------------------------------------
	# INPUT
	# --------------------------------------------------------

	if Input.is_action_just_pressed("move_left"):
		_move_one_tile(-1)

	if Input.is_action_just_pressed("move_right"):
		_move_one_tile(1)


	# --------------------------------------------------------
	# SMOOTH MOVEMENT
	# --------------------------------------------------------

	global_position.x = move_toward(
		global_position.x,
		target_position.x,
		slide_speed * delta
	)


	# --------------------------------------------------------
	# KEEP SHIP ON SCREEN
	# --------------------------------------------------------

	_keep_inside_screen()


	# --------------------------------------------------------
	# SHOOTING
	# --------------------------------------------------------

	fire_timer -= delta

	if Input.is_action_just_pressed("fire"):

		if fire_timer <= 0.0:

			_fire()

			fire_timer = fire_cooldown


# ============================================================
# MOVE ONE TILE
# ============================================================

func _move_one_tile(direction: int) -> void:

	# direction:
	# -1 = left
	# +1 = right

	target_position.x += direction * tile_size

	# Prevent target from going outside the screen.
	var screen_size := get_viewport_rect().size

	var min_x := screen_margin
	var max_x := screen_size.x - screen_margin

	target_position.x = clamp(
		target_position.x,
		min_x,
		max_x
	)


# ============================================================
# SCREEN BOUNDARIES
# ============================================================

func _keep_inside_screen() -> void:

	var screen_size := get_viewport_rect().size

	global_position.x = clamp(
		global_position.x,
		screen_margin,
		screen_size.x - screen_margin
	)


# ============================================================
# FIRE
# ============================================================

func _fire() -> void:

	# Create a new bullet from bullet.tscn.
	var bullet = bullet_scene.instantiate()

	# Put the bullet into the main game scene,
	# not inside the player.
	get_tree().current_scene.add_child(bullet)

	# Start the bullet slightly above the player's ship.
	bullet.global_position = global_position + Vector2(0, -35)

	print("PEW!")
