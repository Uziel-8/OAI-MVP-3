extends CharacterBody2D

const SPEED = 120.0
var health = Globals.health_amount
const INITIAL_JUMP_VELOCITY = -80.0  # Initial jump power
const JUMP_HOLD_FORCE = -60.0        # Continued upward force when holding jump
const MAX_JUMP_TIME = 0.3           # Maximum time the jump can be held

var jump_time = 0.0                   # Tracks how long jump is held

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var timer = $Timer
@onready var inventory: Inventory = Inventory.new()

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 2

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

func die():
	print("Player Died!")
	Engine.time_scale = 0.5
	get_node("CollisionShape2D").queue_free()
	$AnimatedSprite2D.modulate = Color(1, 0, 0)
	Globals.coin_amount = 0
	$DeathTimer.start()

func coin_pickup():
	Globals.add_coin(1)

func _on_coin_amount_changed() -> void:
	pass # Replace with function body.

#Old inventory commented out as i am attempting to implement resource-based inventory
func _input(event):
	if event.is_action_pressed("lmb"):
		animated_sprite_2d.play("Attack")
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
