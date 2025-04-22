extends Node

var EMPTY: Item = Item.new()
const IRON_ORE: Item = preload("res://Resources/Items/iron_ore.tres")
const COAL: Item = preload("res://Resources/Items/coal.tres")
const IRON_BAR: Item = preload("res://Resources/Items/iron_bar.tres")

var all_items = [
	EMPTY,
	COAL,
	IRON_BAR,
	IRON_ORE
]

var item_registry := {}

func _ready() -> void:
	_register_items()
	self.EMPTY.item_name = "EMPTY"
#	SELF COULD BE WRONG HERE - Copied code was "Items.EMPTY..."

func _register_items() -> void:
	for item in all_items:
		item_registry[item.item_name] = item

func get_item(item_name: String) -> Item:
	return item_registry.get(item_name)
