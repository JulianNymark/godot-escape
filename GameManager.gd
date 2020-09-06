extends Node

const CONSTANTS = preload("constants.gd")

onready var MoveController = $MoveController
onready var FightingController = $FightingController
onready var InventoryController = $InventoryController
onready var Earth = $Earth
onready var Items = $Earth/Items
onready var Player = $Earth/Creatures/Player
onready var Inventory = $GUI/InventoryBG/Inventory

# Called when the node enters the scene tree for the first time.
func _ready():
	MoveController.setPos(Player, CONSTANTS.PLAYER_START_IDX)
	
func _process(delta):
	var moveRequestVelocity = Player.MoveHandler()
	
	if moveRequestVelocity.length() != 0: # GAME TICK
		MoveController.move(Earth, Player, moveRequestVelocity)
		# for each creature, calculate intent & action
	
	if Player.DEBUG_SpawnHandler():
		InventoryController.spawnItem(MoveController, Earth, Items, "stick", Player.idx)
	if Player.DEBUG_GrabHandler():
		InventoryController.grabItem(Inventory, Earth, Items, Player.idx)
	if Player.DEBUG_DropHandler():
		InventoryController.dropItem(Inventory, MoveController, Earth, Items, Player.idx)
	if Player.DEBUG_ExitHandler():
		get_tree().quit()
