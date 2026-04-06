extends Control

var IS_ACTIVE = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	$VBoxContainer.process_mode = Node.PROCESS_MODE_ALWAYS

func activate():
	IS_ACTIVE = true
	visible = true
	get_tree().paused = true

func deactivate():
	IS_ACTIVE = false
	visible = false
	get_tree().paused = false

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_to_main_menu_button_pressed() -> void:
	deactivate()
	get_tree().change_scene_to_file("res://game/main_menu/main_menu.tscn") 
