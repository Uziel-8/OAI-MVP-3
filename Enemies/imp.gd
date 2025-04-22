extends Node2D
var speed = 500
var direction = 1
var health: int = 100
var damage: int = 25

@onready var animated_sprite = $AnimatedSprite2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var loot_table: LootTable = LootTable.new()
#var item_drop : PackedScene = preload(itemdrop SCENE goes here)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
	if ray_cast_left.is_colliding():
		direction = 1
	position.x += direction * delta * speed
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

func die():
	drop_item()
	queue_free()
	print("Imp Died!")


func apply_damage(damage_amount: int):
	health -= damage_amount
	print ("imp health ", health)
	if health <= 0:
		die()

func drop_item():
	loot_table.roll_loot
	print(loot_table.item_rolls)

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		body.apply_damage(damage)
