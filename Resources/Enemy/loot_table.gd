class_name LootTable
extends Resource

@export var item_rolls: Array[ItemDrop]

@export var roll_times:= 1



var rng:= RandomNumberGenerator.new()

#can implement item stacks below if i want later - probably will
func roll_loot() -> Array[Item]:
	var items: Array[Item]
	var weights: Array = item_rolls.map(func(roll: ItemDrop): return roll.weight)
	
	for i in roll_times:
		var index:= rng.rand_weighted(weights)
		var roll: ItemDrop = item_rolls[index]
		if roll.item:
			items.append(ItemStack.new(roll.item, roll.count))
	
	return items
