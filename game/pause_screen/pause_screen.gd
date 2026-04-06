extends Control

var game_is_paused = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	$VBoxContainer.process_mode = Node.PROCESS_MODE_ALWAYS

func do_actions():
	get_tree().paused = game_is_paused
	visible = game_is_paused

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
