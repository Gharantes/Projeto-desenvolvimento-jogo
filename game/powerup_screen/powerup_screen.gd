extends Control

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func activate() -> void:
	visible = true
	get_tree().paused = true

func _input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("esc"):
		get_viewport().set_input_as_handled()

func _on_speed_pressed() -> void:
	global.powerups["speed"] += 1
	for gun in get_tree().get_nodes_in_group("gun"):
		gun.apply_speed_powerup()
	_close()

func _on_health_pressed() -> void:
	global.powerups["health"] += 1
	get_tree().get_first_node_in_group("Player").apply_health_powerup()
	_close()

func _on_damage_pressed() -> void:
	global.powerups["damage"] += 1
	_close()

func _close() -> void:
	visible = false
	get_tree().paused = false
