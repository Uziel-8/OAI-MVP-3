class_name Inventory
extends Resource

@export var items: Array[Item]

func add_item(item: Item):
	items.append(item)
	print("added item:", item.item_name)
