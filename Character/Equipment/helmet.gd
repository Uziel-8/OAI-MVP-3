extends Node2D

@export var stats: HelmetStats
#@onready var sprite: Sprite2D = HelmetStats.

var helmet_type: Array[HelmetStats] = [
	preload("res://Resources/Equipment/Helmets/default.tres")]

func _ready():
	pass
