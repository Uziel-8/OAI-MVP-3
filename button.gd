extends Button

func _process(delta):
	pass
#Button is the standard themed button. It can contain text and an icon, and it will display them according to the current Theme.

#Example of creating a button and assigning an action when pressed by code:

func _ready():
	var button = Button.new()
	button.text = "Click me"
	button.pressed.connect(self._button_pressed)
	add_child(button)

func _button_pressed():
	print("Hello world!")
