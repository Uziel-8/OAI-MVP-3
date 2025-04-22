extends RigidBody2D

var damage: int = 25

@export var speed: float = 2000
@export var direction: Vector2 = Vector2.ZERO # declare direction as a variable


func _ready():
	if direction != Vector2.ZERO:
		linear_velocity = direction * speed #moves in the assigned direction
		$SelfDestructTimer.start()
		print("Shuriken launched with velocity:", linear_velocity)  # Debugging
	else:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.apply_damage(damage)
	queue_free()

func _on_self_destruct_timer_timeout():
	queue_free()
	print("gone")


#linear_velocity = direction * speed #moves in the assigned direction
