
extends Node2D

var score: int = 0

@onready var score_label: Label = $HUD/ScoreLabel
@onready var game_over_label: Label = $HUD/GameOverLabel


func _ready() -> void:
	score = 0
	update_score()

	# Hide Game Over when the game starts.
	game_over_label.hide()


func add_score(points: int = 1) -> void:
	score += points
	update_score()


func update_score() -> void:
	score_label.text = "Score: " + str(score)





func game_over() -> void:
	print("GAME OVER FUNCTION CALLED!")

	game_over_label.text = "GAME OVER"
	game_over_label.show()

	get_tree().paused = true
