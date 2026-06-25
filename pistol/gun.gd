extends Area2D

@onready var sfx_attack: AudioStreamPlayer2D = $sfx_attack

var is_enemy_in_range = false

func _ready() -> void:
	add_to_group("gun")
	for _i in global.powerups.get("speed", 0):
		$Timer.wait_time = max(0.05, $Timer.wait_time * 0.75)

func _physics_process(_delta: float) -> void:
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

func apply_speed_powerup() -> void:
	$Timer.wait_time = max(0.05, $Timer.wait_time * 0.75)
	$Timer.start()

func _on_timer_timeout() -> void:
	if is_enemy_in_range:
		shoot()
