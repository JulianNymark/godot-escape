extends Node2D

enum Cardinals {N, S, E, W}

const CONSTANTS = preload("constants.gd")

const SPEED = 100

var animationPlayer = null
var facing = Cardinals.S
var velocity = Vector2(0, 0)
var idx = Vector2(0, 0)

func _ready():
	animationPlayer = $AnimationPlayer

func _process(delta):	
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
	
	handleAnimation(facing)
	
	idx += velocity
	self.position = idx * CONSTANTS.GRID_SIZE

func handleAnimation(direction):
	if (direction == Cardinals.E):
		animationPlayer.play("WalkEast");
	elif (direction == Cardinals.W):
		animationPlayer.play("WalkWest");
	elif (direction == Cardinals.S):
		animationPlayer.play("WalkSouth");
	elif (direction == Cardinals.N):
		animationPlayer.play("WalkNorth");
