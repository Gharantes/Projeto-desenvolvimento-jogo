extends Node

var round_type = "Day"

func _ready() -> void:
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		var vol = config.get_value("audio", "mobs_volume", 1.0)
		AudioServer.set_bus_volume_db(
			AudioServer.get_bus_index("Mobs"),
			linear_to_db(vol)
		)
