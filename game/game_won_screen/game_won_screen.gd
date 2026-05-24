extends Control

var IS_ACTIVE = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	$CenterContainer.process_mode = Node.PROCESS_MODE_ALWAYS

func activate(round_value: int) -> void:
	IS_ACTIVE = true
	visible = true
	%RoundCongratulationLabel.text = "Congratulations, you survived until round " + str(round_value) + "!"
	get_tree().paused = true

func deactivate():
	IS_ACTIVE = false
	visible = false
	get_tree().paused = false

func _on_quit_to_main_menu_button_pressed() -> void:
	deactivate()
	get_tree().change_scene_to_file("res://game/main_menu/main_menu.tscn") 

func _on_quit_to_desktop_button_pressed() -> void:
	get_tree().quit()

func _on_continue_button_pressed() -> void:
	deactivate()
	
