extends Node

var round_type = "Day"
var wood_count: int = 0
var powerups: Dictionary = {"speed": 0, "health": 0, "damage": 0}

func _ready() -> void:
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		var vol = config.get_value("audio", "mobs_volume", 1.0)
		AudioServer.set_bus_volume_db(
			AudioServer.get_bus_index("Mobs"),
			linear_to_db(vol)
		)
