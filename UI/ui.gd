extends CanvasLayer

@onready var coin_label = $LabelCoin
@onready var health_bar: TextureProgressBar = $MarginContainer/HealthBar
@onready var shuriken_label = $LabelShuriken

func _ready():
	Globals.connect("coin_amount_changed", Callable(self, "_on_coin_amount_changed"))
	Globals.connect("shuriken_amount_changed", Callable(self, "_on_shuriken_amount_changed"))
	Globals.connect("health_amount_changed", Callable(self, "_on_health_amount_changed"))
	#update_health_text()
	print(health_bar.value)
	health_bar.value = Globals.health_amount

func _on_coin_amount_changed(new_coin_amount):
	coin_label.text = str(new_coin_amount)

func _on_shuriken_amount_changed(new_shuriken_amount):
	$LabelShuriken.text = str(new_shuriken_amount)

func update_health_text(new_health_amount):
	health_bar.value = Globals.new_health_amount
	print(Globals.health_amount)

func update_stat_text():
	pass
	#update_health_text()
