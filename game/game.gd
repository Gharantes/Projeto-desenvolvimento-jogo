extends Node2D

@onready var round_countdown: Control = $CanvasLayer/RoundCountdown

var do_spawn_mobs = true

const TREE_SCENE = preload("res://trees/pine_tree.tscn")
const NUM_TREES = 8
const MIN_DIST_FROM_CAMPFIRE = 250.0
const MIN_DIST_FROM_PLAYER = 150.0
const MAX_DIST_FROM_PLAYER = 900.0

func _ready() -> void:
	global.wood_count = 0
	global.powerups = {"speed": 0, "health": 0, "damage": 0}
	round_countdown.day_started.connect(_on_day_started)
	round_countdown.night_started.connect(_on_night_started)
	round_countdown.last_night_survived.connect(_on_last_night_survived)
	_on_day_started()
	%Campfire.campfire_extinguished.connect(_on_campfire_extinguished)
	%ExperienceBar.level_up.connect(_on_level_up)

func _on_level_up(new_level: int) -> void:
	if new_level == 5:
		$Player.add_second_gun()
	else:
		%PowerupScreen.activate()

func _process(_delta: float) -> void:
	%WoodCounter.text = "Madeira: %d" % global.wood_count
	_update_campfire_marker()
	
	if global.round_type == "Night":
		%ColorRect.color = Color.DIM_GRAY
		%WoodCounter.add_theme_color_override("font_color", Color.WHITE)
		%CampfireMarker.add_theme_color_override("font_color", Color.WHITE)
	else:
		%ColorRect.color = Color.WHITE
		%WoodCounter.add_theme_color_override("font_color", Color.BLACK)
		%CampfireMarker.add_theme_color_override("font_color", Color.BLACK)

func _update_campfire_marker() -> void:
	var dir = %Campfire.global_position - $Player.global_position
	var angle = dir.angle()
	var arrows = ["→", "↘", "↓", "↙", "←", "↖", "↑", "↗"]
	var idx = int(round(angle / (PI / 4.0))) % 8
	if idx < 0:
		idx += 8
	%CampfireMarker.text = "Fogueira " + arrows[idx]

func _spawn_trees() -> void:
	var player_pos = $Player.global_position
	var campfire_pos = %Campfire.global_position
	for i in NUM_TREES:
		for _attempt in 50:
			var angle = randf() * TAU
			var dist = randf_range(MIN_DIST_FROM_PLAYER, MAX_DIST_FROM_PLAYER)
			var pos = player_pos + Vector2(cos(angle), sin(angle)) * dist
			if pos.distance_to(campfire_pos) >= MIN_DIST_FROM_CAMPFIRE:
				var tree = TREE_SCENE.instantiate()
				add_child(tree)
				tree.global_position = pos
				break

func _on_day_started():
	do_spawn_mobs = false
	get_tree().call_group("mobs", "die")
	get_tree().call_group("tree", "queue_free")
	_spawn_trees()

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

func _on_last_night_survived() -> void:
	%GameWonScreen.activate(round_countdown.round_value)

func _on_campfire_extinguished() -> void:
	%GameOverScreen.activate()
