extends Area2D
signal element_triggered

func _on_body_entered(body):
	if body.name == "Player":
		emit_signal("element_triggered")
