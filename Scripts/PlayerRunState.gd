extends State

class_name PlayerRun

@export var speed : float = 200
var player

func Enter():
	player = get_parent().get_parent()
	player.get_node("AnimatedSprite2D").play("Run")

func Physics_Update(delta):
	var direction 

func Update(delta):
	pass
	
