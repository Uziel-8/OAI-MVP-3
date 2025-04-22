class_name ItemStack

signal item_changed(item: Item)

static var max_count:= 100
var items = preload("res://Resources/Misc/items.gd")

var item: Item:
	set(val):
		item = val
		item_changed.emit(val)

var count: int

func _init(item: Item, count: int = 0):
	self.item = item
	self.count = count

func is_empty() -> bool:
	return item == items.EMPTY

func _to_string() -> String:
	return "Item: " + str(item) + " - " + str(count)
