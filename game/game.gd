extends Node2D


const MAX_MOBS = 25
var current_mobs = 0

func spawn_mob():
	var new_mob = preload("res://characters/slime/mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)

func _on_timer_timeout() -> void:
	if current_mobs < MAX_MOBS: 
		spawn_mob()
		current_mobs += 1
	
func _on_player_health_depleted() -> void:
	%GameOverScreen.activate()
	
