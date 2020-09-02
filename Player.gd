extends Node2D

enum Cardinals {N, S, E, W}

const SPEED = 100

var animationPlayer = null
var facing = Cardinals.S
var velocity = null
var idx = null

func _ready():
	animationPlayer = $AnimationPlayer

func _process(delta):	
	handleAnimation(self.facing)

func handleAnimation(direction):
	if (direction == Cardinals.E):
		animationPlayer.play("WalkEast");
	elif (direction == Cardinals.W):
		animationPlayer.play("WalkWest");
	elif (direction == Cardinals.S):
		animationPlayer.play("WalkSouth");
	elif (direction == Cardinals.N):
		animationPlayer.play("WalkNorth");

func InputHandler() -> Vector2:
	velocity = Vector2(0, 0)
	if (Input.is_action_just_pressed("ui_up")):
		facing = Cardinals.N
		velocity = Vector2(0, -1)
	elif (Input.is_action_just_pressed("ui_down")):
		facing = Cardinals.S
		velocity = Vector2(0, 1)
	elif (Input.is_action_just_pressed("ui_left")):
		facing = Cardinals.W
		velocity = Vector2(-1, 0)
	elif (Input.is_action_just_pressed("ui_right")):
		facing = Cardinals.E
		velocity = Vector2(1, 0)
	
	return velocity
	
