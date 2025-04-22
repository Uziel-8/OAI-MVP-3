class_name Enemy
extends CharacterBody2D

#@export var stats: EnemyStats ##EnemyStats needs to be created

#var item_drop : PackedScene = preload(itemdrop SCENE goes here)

func on_death() -> void:
	if stats.loot_table:
		for stack: ItemStack in stats.loot_table.roll_loot():
			var spawned_item: ItemDrop = item_drop.instantiate
			spawned_item.stack = stack
			spawned_item.global_position = global_position
			get_tree().current_scene.add_child.call_deferred(sp.......)
