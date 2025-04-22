extends Control

var inventory : Inventory = Inventory.new()
#I want to make this similar to the original test menu, but utilizing the
# resource based inventory system. should be simple to set up, i think
# everything is working. Need to check on item stack and inventory array
# functionality. this will be a good way to test without having to create
# a whole new enemy.
func ready():
	if inventory == null:
		inventory = Inventory.new()  # Create a new instance if none exists
	#print("Methods:", inventory.get_method_list())  # See what functions exist


func _on_add_coal_pressed() -> void:
	self.Inventory.add_item(Items.COAL)
	print("Inventory:", inventory)  # Check if it's null
