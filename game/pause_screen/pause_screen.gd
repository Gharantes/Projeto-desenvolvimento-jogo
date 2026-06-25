extends Control

var game_is_paused = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	$VBoxContainer.process_mode = Node.PROCESS_MODE_ALWAYS

func do_actions():
	get_tree().paused = game_is_paused
	visible = game_is_paused
	if game_is_paused:
		_update_powerup_list()

func _update_powerup_list() -> void:
	var p = global.powerups
	var lines: Array = []
	if p.get("speed", 0) > 0:
		lines.append("Vel. de tiro: %dx" % p["speed"])
	if p.get("health", 0) > 0:
		lines.append("Mais vida: %dx" % p["health"])
	if p.get("damage", 0) > 0:
		lines.append("Mais dano: %dx" % p["damage"])
	var second_gun = get_tree().get_first_node_in_group("Player")
	if second_gun and second_gun.get_child_count() > 0:
		var guns = get_tree().get_nodes_in_group("gun")
		if guns.size() > 1:
			lines.append("2ª arma: ativa")
	if lines.is_empty():
		%PowerupList.text = "(sem poderes ainda)"
	else:
		%PowerupList.text = "\n".join(lines)

func _unhandled_input(event: InputEvent) -> void:
	if %GameOverScreen.IS_ACTIVE:
		return
	if Input.is_action_just_pressed("esc"):
		game_is_paused = !game_is_paused
		do_actions()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_resume_button_pressed() -> void:
	game_is_paused = false
	do_actions()

func _on_settings_button_pressed() -> void:
	%SettingsMenu.activate()

func _on_quit_to_main_menu_button_pressed() -> void:
	game_is_paused = false
	do_actions()
	get_tree().change_scene_to_file("res://game/main_menu/main_menu.tscn") 
