extends Node

const CONSTANTS = preload("constants.gd")

onready var Map = $World/Map
onready var MoveController = $MoveController
onready var FightingController = $FightingController
onready var Player = $World/Creatures/Player

# Called when the node enters the scene tree for the first time.
func _ready():
	Player.idx = CONSTANTS.PLAYER_START_IDX
	
func _process(delta):
	var playerVelocity = Player.InputHandler()
	
	if playerVelocity.length() != 0: # GAME TICK
		MoveController.move(Map, Player, playerVelocity)
