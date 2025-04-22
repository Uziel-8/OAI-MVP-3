extends Area2D
var damage: int = 50


func _on_body_entered(body):
	if "apply_damage" in body:
		body.apply_damage(damage)
