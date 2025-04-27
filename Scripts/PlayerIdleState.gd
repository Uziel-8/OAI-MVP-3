extends State

class_name PlayerIdle

var player

func Enter():
	player = get_parent().get_parent()
	player.get_node("AnimatedSprite2D").play("Idle")

func Physics_Update(delta):
	var direction
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		State.current_state = PlayerRun

func Update(delta):
	pass
