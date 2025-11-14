extends Control

signal hovered(tile)
signal pressed(tile)

var letter: String
var is_selected := false

func set_letter(l):
	letter = l
	$Label.text = l.upper()

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			emit_signal("pressed", self)

	if event is InputEventMouseMotion and event.button_mask & MOUSE_BUTTON_MASK_LEFT:
		emit_signal("hovered", self)

func highlight():
	is_selected = true
	$Panel.modulate = Color(0.2, 0.5, 1.0)

func reset_highlight():
	is_selected = false
	$Panel.modulate = Color(1, 1, 1)
