extends Node2D

@onready var round_countdown: Control = $CanvasLayer/RoundCountdown
var do_spawn_mobs = true

func _ready() -> void:
	round_countdown.day_started.connect(_on_day_started)
	round_countdown.night_started.connect(_on_night_started)
	_on_day_started()
	
func _on_day_started():
	do_spawn_mobs = false
	get_tree().call_group("mobs", "die")

func _on_night_started():
	do_spawn_mobs = true

func spawn_mob():
	if do_spawn_mobs == false: return
	var new_mob = preload("res://characters/slime/mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	new_mob.was_killed_by_player.connect(_mob_killed)

func _on_timer_timeout() -> void:
	spawn_mob()
	
func _on_player_health_depleted() -> void:
	%GameOverScreen.activate()
	
func _mob_killed() -> void:
	%ExperienceBar.add_experience(1)
