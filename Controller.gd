extends Node2D

enum Cardinals {N, S, E, W}

var SPEED = 100
var animationPlayer = null
var facing = Cardinals.S

func _ready():
	animationPlayer = $AnimationPlayer

func _process(delta):
	var velocity = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	
	handleAnimation(velocity)
	
	self.position += (velocity * SPEED * delta)

func handleAnimation(velocity):
	if (velocity.x > 0):
		facing = Cardinals.E
		animationPlayer.play("WalkEast");
	elif (velocity.x < 0):
		facing = Cardinals.W
		animationPlayer.play("WalkWest");
	elif (velocity.y > 0):
		facing = Cardinals.S
		animationPlayer.play("WalkSouth");
	elif (velocity.y < 0):
		facing = Cardinals.N
		animationPlayer.play("WalkNorth");
		
	
	
