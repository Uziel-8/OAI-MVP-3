extends Area2D

@export var is_open = false
@onready var animated_sprite = $AnimatedSprite2D  # Make sure the path is correct.
@onready var selection_menu = preload("res://UI/selection_menu.tscn")
@onready var player = get_node("/root/Player")  # Reference to the player

func _ready():
	connect("area_entered", Callable(self, "_on_area_entered"))
	connect("area_exited", Callable(self, "_on_area_exited"))

func _on_area_entered(area):
	if area.is_in_group("player"):  # Make sure your player is in the "player" group
		set_process(true)  # Enables processing so _process can detect input

func _on_area_exited(area):
	if area.is_in_group("player"):
		set_process(false)

func _process(_delta):
	if Input.is_action_just_pressed("interact") and not is_open:
		open_chest()

func open_chest():
	is_open = true
	animated_sprite.play("open")  # Play the "open" animation
	print("Opening chest")
	
	var menu_instance = selection_menu.instantiate()
	get_tree().root.add_child(menu_instance)
	
	var chest_position = global_position
	menu_instance.position = chest_position + Vector2(-200, -200)
	
	menu_instance.show_menu()
	set_process_input(false) #reset chest
	
	
