extends Control

var level = 1
var needed_experience = 10
var current_experience = 0

var progress_bar_value = 0

func _calc_progress_bar_value():
	progress_bar_value = (float(current_experience) / float(needed_experience)) * 100
	%ExperienceBar.value = progress_bar_value

func add_experience(value: int) -> void:
	current_experience += value
	if current_experience >= needed_experience:
		level += 1
		current_experience -= needed_experience
	_calc_progress_bar_value()
	%LevelLabel.text = "Level: " + str(level)
