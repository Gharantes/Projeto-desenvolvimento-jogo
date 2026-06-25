extends StaticBody2D

signal campfire_extinguished

const WOOD_BURN_TIME = 5.0
const INITIAL_FUEL = 30.0

var fuel_remaining: float = INITIAL_FUEL
var player_nearby: bool = false

@onready var timer_label: Label = %TimerLabel
@onready var press_e_label: Label = %PressELabel

func _ready() -> void:
	press_e_label.visible = false

func _process(delta: float) -> void:
	fuel_remaining -= delta
	timer_label.text = "%d" % max(0, fuel_remaining)
	if fuel_remaining <= 0:
		campfire_extinguished.emit()
		set_process(false)
	if global.round_type == "Night":
		timer_label.add_theme_color_override("font_color", Color.WHITE)
		press_e_label.add_theme_color_override("font_color", Color.WHITE)
	else:
		timer_label.add_theme_color_override("font_color", Color.BLACK)
		press_e_label.add_theme_color_override("font_color", Color.BLACK)


func _input(event: InputEvent) -> void:
	if player_nearby and event.is_action_pressed("e"):
		if global.wood_count > 0:
			global.wood_count -= 1
			fuel_remaining += WOOD_BURN_TIME

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_nearby = true
		press_e_label.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_nearby = false
		press_e_label.visible = false
