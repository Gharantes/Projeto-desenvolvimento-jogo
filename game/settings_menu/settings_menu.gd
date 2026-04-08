extends Control

@onready var audio_slider: HSlider = %AudioSlider

var IS_ACTIVE = false

func _ready() -> void:
	load_settings()  # load as soon as settings scene opens
	process_mode = Node.PROCESS_MODE_ALWAYS
	$Panel.process_mode = Node.PROCESS_MODE_ALWAYS
	
func _on_close_button_pressed() -> void:
	deactivate()

func activate():
	IS_ACTIVE = true
	visible = true

func deactivate():
	print("Teste")
	IS_ACTIVE = false
	visible = false

func _on_audio_slider_value_changed(value: float) -> void:
	# value expected 0.0 to 1.0
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Audio"), db)

func save_settings() -> void:
	var config = ConfigFile.new()
	config.set_value("audio", "volume", audio_slider.value)
	config.save("user://settings.cfg")

func load_settings() -> void:
	var config = ConfigFile.new()
	# Default to 1.0 whether or not the file exists
	var vol = 1.0
	if config.load("user://settings.cfg") == OK:
		vol = config.get_value("audio", "volume", 1.0)
	
	audio_slider.value = vol  # always set the slider
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Audio"),
		linear_to_db(vol)
	)
