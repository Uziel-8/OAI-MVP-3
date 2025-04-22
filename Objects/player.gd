extends CharacterBody2D

const SPEED = 1200.0
var health = Globals.health_amount
const INITIAL_JUMP_VELOCITY = -800.0  # Initial jump power
const JUMP_HOLD_FORCE = -600.0        # Continued upward force when holding jump
const MAX_JUMP_TIME = 0.3           # Maximum time the jump can be held

var jump_time = 0.0                   # Tracks how long jump is held
var can_shuriken: bool = true
signal shuriken_red(pos, direction)

@onready var shuriken_scene = preload("res://Character/shuriken.tscn")
@onready var shuriken_red_scene = preload("res://Character/shuriken_red.tscn")
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var timer = $Timer
@onready var inventory: Inventory = Inventory.new()

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 5

func _physics_process(delta):
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = INITIAL_JUMP_VELOCITY
			jump_time = 0.0
	else:
		if Input.is_action_pressed("jump") and jump_time < MAX_JUMP_TIME:
			velocity.y += JUMP_HOLD_FORCE * delta
			jump_time += delta
		else:
			velocity.y += gravity * delta
	
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_pressed("left"):
		animated_sprite_2d.flip_h = true
	if Input.is_action_pressed("right"):
		animated_sprite_2d.flip_h = false

	move_and_slide()

func _process(_delta):
	var mouse_pos = get_global_mouse_position()
	var direction = mouse_pos - global_position
	
	#rotate sword to point towards mouse
	$SwordArea.rotation = direction.angle()
	
	#throw a shuriken towards mouse
	if Input.is_action_just_pressed("throw") and can_shuriken and Globals.shuriken_amount > 0:
		Globals.shuriken_amount -= 1
		throw_shuriken(direction) #pass direction to throw_shuriken function
		print("Thrown")
	
	#if Input.is_action_just_pressed("mmb"):
		#shuriken_red.emit($SwordArea.global_position)
		#throw_shuriken_red()
		#print("red")

func throw_shuriken(direction: Vector2):
	var shuriken_instance = shuriken_scene.instantiate()
	get_parent().add_child(shuriken_instance) # Add to the same level as the player
	
	var shoot_direction = (get_global_mouse_position() - global_position).normalized()
	shuriken_instance.global_position = global_position + (shoot_direction * 30) # Start from player position
	shuriken_instance.direction = shoot_direction
	print("Shuriken Spawned. Direction:", shoot_direction)

#func throw_shuriken_red():
	#var shuriken_red_instance = shuriken_red_scene.instantiate()
	#get_parent().add_child(shuriken_red_instance)
	#pass

func die():
	print("Player Died!")
	Engine.time_scale = 0.5
	get_node("CollisionShape2D").queue_free()
	$AnimatedSprite2D.modulate = Color(1, 0, 0)
	Globals.coin_amount = 0
	Globals.shuriken_amount = 5
	$DeathTimer.start()


func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()


func apply_damage(damage_amount: int):
	health -= damage_amount
	health = max(health, 0) #prevents negative health
	emit_signal("health_amount_changed", health)
	print ("player health ", health)
	$IFrame.start()
	if health <= 0:
		die()


func _on_i_frame_timeout() -> void:
	pass # Replace with function body.


func coin_pickup():
	Globals.add_coin(1)

func _on_coin_amount_changed() -> void:
	pass # Replace with function body.


#Old inventory commented out as i am attempting to implement resource-based inventory
func _input(event):
	if event.is_action_pressed("inventory"):
		print(inventory.items)
		#$Inventory.visible = !$Inventory.visible
		#print("open sesame")
	if event.is_action_pressed("mmb"):
		inventory.add_item(Items.COAL)
		print("Coal added!")
	if event.is_action_pressed("backspace"):
		inventory.add_item(Items.IRON_ORE)
		print("Iron Ore added!")
	if event.is_action_pressed("enter"):
			pass

func pick_up_item(item_name):
	Globals.add_item(item_name)


func _on_shuriken_red(pos: Variant, direction: Variant) -> void:
	pass # Replace with function body.
