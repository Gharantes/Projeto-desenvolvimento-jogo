extends Control

var value = 0

func _on_timer_timeout() -> void:
	value += 10
	%ProgressBar.value = value
	if value >= 100:
		get_tree().change_scene_to_file("res://game/game.tscn") 
