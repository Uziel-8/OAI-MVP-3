extends RigidBody2D

var speed = 2000
var direction: Vector2 = Vector2.UP


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta
