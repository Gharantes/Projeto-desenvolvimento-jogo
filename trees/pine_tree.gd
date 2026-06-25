extends StaticBody2D

var POP_UP_VISIBLE = false
var TREE_IS_CUT = false

func _ready() -> void:
	hide_popup()
	%CutPineTree.visible = false

func _process(delta: float) -> void:
	if POP_UP_VISIBLE == true && Input.is_action_just_pressed("e"):
		cut_wood()
	if POP_UP_VISIBLE == true and should_pop_up_appear() == false:
		hide_popup()
		
func cut_wood():
	global.wood_count += 1
	TREE_IS_CUT = true
	%PineTree.visible = false
	%CutPineTree.visible = true
	$CollisionShape2D.disabled = true
	hide_popup()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") && should_pop_up_appear():
		show_popup()

func should_pop_up_appear():
	return global.round_type == "Day" and TREE_IS_CUT == false

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		hide_popup()

func show_popup():
	POP_UP_VISIBLE = true
	%PressEBox.visible = POP_UP_VISIBLE

func hide_popup():
	POP_UP_VISIBLE = false
	%PressEBox.visible = POP_UP_VISIBLE
