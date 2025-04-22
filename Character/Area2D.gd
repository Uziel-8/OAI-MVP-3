extends Area2D
var damage: int = 100


func _ready():
	pass # Replace with function body.

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.apply_damage(damage)
