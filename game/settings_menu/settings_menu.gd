extends Control

var IS_ACTIVE = false

func _ready() -> void:
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
