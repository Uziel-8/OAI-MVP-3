extends Control


func _on_button_mouse_entered() -> void:
	$Button/Label.visible = true



func _on_button_mouse_exited() -> void:
	$Button/Label.visible = false
