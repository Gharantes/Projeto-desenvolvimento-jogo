extends Area2D

@onready var sfx_attack: AudioStreamPlayer2D = $sfx_attack

var is_enemy_in_range = false

func _physics_process(delta: float) -> void:
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		is_enemy_in_range = true
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)
	else:
		is_enemy_in_range = false

func shoot():
	const BULLET = preload("res://pistol/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)
	sfx_attack.play()

func _on_timer_timeout() -> void:
	if is_enemy_in_range:
		shoot()
