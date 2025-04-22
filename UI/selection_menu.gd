extends Control

@onready var button_gold = $Gold
@onready var button_health = $Health
@onready var button_shuriken = $Shuriken

func _ready():
	button_gold.connect("pressed", Callable(self, "_on_gold_pressed"))
	button_health.connect("pressed", Callable(self, "_on_health_pressed"))
	button_shuriken.connect("pressed", Callable(self, "_on_shuriken_pressed"))

func _on_gold_pressed():
	print("gold Taken")
	Globals.add_coin(5)
	# Add item to player inventory here or call any other function
	hide_menu()

func _on_health_pressed():
	print("Health Taken")
	Globals.add_item("potion")
	hide_menu()

func _on_shuriken_pressed():
	print("Shurikens Taken")
	Globals.shuriken_amount += 5
	hide_menu()

func show_menu():
	visible = true

func hide_menu():
	visible = false
