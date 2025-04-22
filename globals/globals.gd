extends Node

signal coin_amount_changed(new_coin_amount: int)
signal shuriken_amount_changed(new_shuriken_amount: int)
signal health_amount_changed(new_health_amount: int)
signal inventory_updated

#var inventory: Array = [] #list to hold all inventory items
#var item_data = {
	#"potion": {"name": "Health Potion", "description": "Recovers health", "icon": preload("res://Graphics/UI/Red Button.png")}
#}

@export var inventory: Inventory



var health_amount: int = 60:
	set(value):
		health_amount = value
		emit_signal("health_amount_changed", health_amount)
		print("health_amount_changed", health_amount)

var coin_amount: int = 0:
	set(value):
		coin_amount = value
		emit_signal("coin_amount_changed", coin_amount)
		print("coin amount updated:", coin_amount)

var shuriken_amount: int = 5:
	set(value):
		shuriken_amount = value
		emit_signal("shuriken_amount_changed", shuriken_amount)
		print("shuriken amount updated:", shuriken_amount)

# Function to add a coin and emit the signal
func add_coin(amount: int):
	coin_amount += amount
	emit_signal("coin_amount_changed", coin_amount)

func add_shuriken(amount: int):
	shuriken_amount += amount
	emit_signal("shuriken_amount_changed", shuriken_amount)

## Adds an item to the inventory
#func add_item(item):
	#inventory.append(item)
	#print("added item:", item)
#
##removes an item from the inventory
#func remove_item(item):
	#if item in inventory:
		#inventory.erase(item)
		#print("Removed item:", item)
#
##checks if the inventory contains a specific items
#func has_item(item) -> bool:
	#return item in inventory
#
#func ready():
	#if inventory == null:
		#print("Inventory is NULL! Creating new instance.")
		#inventory = Inventory.new()
	#else:
		#print("Inventory is READY:", inventory)
