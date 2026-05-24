extends Control
const ROUND_TIME = 10

var round_value = 1
var timer_value = ROUND_TIME

signal day_started()
signal night_started()
signal last_night_survived()

func _ready() -> void:
	_start_day()

func _on_timer_timeout() -> void:
	timer_value -= 1
	if timer_value == 0:
		toggle_round_type()
		return
	_update_labels()

func toggle_round_type() -> void:
	if global.round_type == "Day": _start_night()
	else: 
		round_value += 1
		_start_day()
		if round_value >= 3:
			last_night_survived.emit()

func _start_night():
	global.round_type = "Night"
	night_started.emit()
	timer_value = ROUND_TIME
	_update_labels()

func _start_day():
	global.round_type = "Day"
	day_started.emit()
	timer_value = ROUND_TIME
	_update_labels()

func _update_labels():
	%RoundTypeLabel.text = "Round Type: " + global.round_type
	%CountdownLabel.text = "Round Countdown: " + str(timer_value) + "s"
	%RoundLabel.text = "Round: " + str(round_value)
	
