extends Button

signal mine

func _on_pressed() -> void:
	Globals.inventory.add_item(Items.COAL)
	print(Globals.inventory)
	#$Timer.start


func _on_timer_timeout() -> void:
	pass
	#Globals.inventory.add_item(Items.COAL)
	#print(Globals.inventory)
