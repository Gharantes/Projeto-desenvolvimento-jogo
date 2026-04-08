extends Control
const ROUND_TIME = 5

var round_type = "Day"
var timer_value = ROUND_TIME

signal day_started()
signal night_started()

func _ready() -> void:
	_start_day()

func _on_timer_timeout() -> void:
	timer_value -= 1
	if timer_value == 0:
		toggle_round_type()
		return
	_update_labels()

func toggle_round_type() -> void:
	if round_type == "Day": _start_night()
	else: _start_day()

func _start_night():
	round_type = "Night"
	night_started.emit()
	timer_value = ROUND_TIME
	_update_labels()

func _start_day():
	round_type = "Day"
	day_started.emit()
	timer_value = ROUND_TIME
	_update_labels()

func _update_labels():
	%RoundTypeLabel.text = "Round Type: " + round_type
	%CountdownLabel.text = "Round Countdown: " + str(timer_value) + "s"
	
