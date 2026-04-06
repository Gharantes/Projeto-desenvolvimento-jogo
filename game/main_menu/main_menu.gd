extends Control


func _on_new_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game/loading_screen/loading_screen.tscn") 

func _on_settings_button_pressed() -> void:
	$SettingsMenu.activate()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
