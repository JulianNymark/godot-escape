extends Node2D

var SPEED = 100;

func _ready():
	pass

func _process(delta):
	var velocity = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	
	self.position += (velocity * SPEED * delta)
