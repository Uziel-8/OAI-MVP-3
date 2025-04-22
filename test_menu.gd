extends Control

@onready var cash_label = $LabelPanelContainer/CashLabel
@onready var coal_label = $LabelPanelContainer/CoalLabel
@onready var iron_ore_label = $LabelPanelContainer/IronOreLabel
@onready var x2button = $x2Button
@onready var x5button = $x5Button
@onready var workerbutton = $WorkerButton
@onready var worktimer = $WorkerButton/WorkTimer
@onready var iron_bar_label = $BlueprintContainer/IronBar/IronBarQty
@onready var iron_dagger_label = $BlueprintContainer/IronDagger/IronDaggerQty

signal cash_amount_changed(new_cash_amount: int)
signal coal_amount_changed(new_coal_amount: int)
signal iron_ore_amount_changed(new_iron_ore_amount: int)
signal iron_bar_amount_changed(new_iron_bar_amount: int)
signal iron_dagger_amount_changed(new_iron_dagger_amount: int)

var multiplier: int = 1
var total_cash: int = 0

var cash_amount: int = 0:
	set(value):
		cash_amount = value
		emit_signal("cash_amount_changed", cash_amount)
		print("cash_amount_changed ", cash_amount)
var iron_ore_amount: int = 0:
	set(value):
		iron_ore_amount = value
		emit_signal("iron_ore_amount_changed", iron_ore_amount)
		print("iron_ore_amount_changed ", iron_ore_amount)
var coal_amount: int = 0:
	set(value):
		coal_amount = value
		emit_signal("coal_amount_changed", coal_amount)
		print("coal_amount_changed ", coal_amount)
var iron_bar_amount: int = 0:
	set(value):
		iron_bar_amount = value
		emit_signal("iron_bar_amount_changed", iron_bar_amount)
var iron_dagger_amount: int = 0:
	set(value):
		iron_dagger_amount = value
		emit_signal("iron_dagger_amount_changed", iron_dagger_amount)

func _on_button_pressed():
	cash_amount += (multiplier * 5)
	total_cash += (multiplier * 5)

func _on_cash_amount_changed(new_cash_amount: int) -> void:
	cash_label.text = str(new_cash_amount)
	print(total_cash)
	if cash_amount > 20:
		x2button.visible = true
	if cash_amount > 50:
		x5button.visible = true
	if cash_amount > 5:
		workerbutton.visible = true

func _on_coal_amount_changed(new_coal_amount: int) -> void:
	coal_label.text = str(new_coal_amount)

func _on_iron_ore_amount_changed(new_iron_ore_amount: int) -> void:
	iron_ore_label.text = str(new_iron_ore_amount)

func _on_x_2_button_pressed():
	cash_amount -= 20
	multiplier = 2
	x2button.disabled = true

func _on_x_5_button_pressed() -> void:
	cash_amount -= 50
	multiplier += 5
	x5button.disabled = true

func _on_worker_button_pressed():
	cash_amount -= 1
	workerbutton.disabled = true
	worktimer.start()

func _ready():
	pass
	#var button = Button.new()
	#button.text = "Click me"
	#button.pressed.connect(_button_pressed)
	#add_child(button)

func process(delta):
	$ProgressBar.set_value = cash_amount

func _on_work_timer_timeout() -> void:
	iron_ore_amount += 1
	coal_amount += 1
	worktimer.start()

func _on_build_iron_bar_pressed() -> void:
	if cash_amount > 50 and coal_amount > 5 and iron_ore_amount >10:
		cash_amount -= 50
		coal_amount -= 5
		iron_ore_amount -= 10
		iron_bar_amount += 1

#test did not work, need google
#var resources: Array = ["iron_bar", "iron_dagger"]
#var resource_data = {}

func _on_iron_bar_amount_changed(new_iron_bar_amount: int) -> void:
	iron_bar_label.text = str(new_iron_bar_amount)

func _on_iron_dagger_amount_changed(new_iron_dagger_amount: int) -> void:
	iron_dagger_label.text = str(new_iron_dagger_amount)

func _on_merchant_about_to_popup() -> void:
	pass # Replace with function body.


func _on_buy_bar_pressed() -> void:
	cash_amount -= randi_range(10, 100)
#	this works, need to re-write all resources a little bit so they cant go below 0
