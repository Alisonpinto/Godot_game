
extends Area2D

var game_over_triggered: bool = false

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	print("BLUE LINE READY")


func _on_area_entered(area: Area2D) -> void:
	if not area.is_in_group("enemy"):
		return

	print("ENEMY REACHED BLUE LINE!")

	var game_manager = get_tree().current_scene

	if game_manager.has_method("game_over"):
		game_manager.game_over()
