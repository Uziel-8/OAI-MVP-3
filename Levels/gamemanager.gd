extends Node

@onready var game_manager = %GameManager
@onready var coin_label = $"../Player/CoinLabel"




var coins = 0

func coin_pickup():
	coins += 1
	print(coins)
	coin_label.text = str(coins)
	
