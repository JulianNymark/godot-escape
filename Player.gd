extends Node2D

enum Cardinals {N, S, E, W}

const SPEED = 100

var animationPlayer = null
var facing = Cardinals.S
var velocity = null
var idx = null
var creatureName = "Player"
var strength = 8
var health = 20
var armor = 0

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

func MoveHandler() -> Vector2:
	velocity = Vector2(0, 0)
	if (Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("key_k")):
		facing = Cardinals.N
		velocity = Vector2(0, -1)
	elif (Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("key_j")):
		facing = Cardinals.S
		velocity = Vector2(0, 1)
	elif (Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("key_h")):
		facing = Cardinals.W
		velocity = Vector2(-1, 0)
	elif (Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("key_l")):
		facing = Cardinals.E
		velocity = Vector2(1, 0)
	elif Input.is_action_just_pressed("key_y"):
		facing = Cardinals.N
		velocity = Vector2(-1, -1)
	elif Input.is_action_just_pressed("key_u"):
		facing = Cardinals.N
		velocity = Vector2(1, -1)
	elif Input.is_action_just_pressed("key_b"):
		facing = Cardinals.S
		velocity = Vector2(-1, 1)
	elif Input.is_action_just_pressed("key_n"):
		facing = Cardinals.S
		velocity = Vector2(1, 1)	
	return velocity
	
func DEBUG_SpawnHandler():
	return Input.is_action_just_pressed("key_s")

func DEBUG_GrabHandler():
	return Input.is_action_just_pressed("key_g")

func DEBUG_DropHandler():
	return Input.is_action_just_pressed("key_d")
	
func DEBUG_ExitHandler():
	return Input.is_action_just_pressed("ui_cancel")
