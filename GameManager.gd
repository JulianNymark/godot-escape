extends Node

const CONSTANTS = preload("constants.gd")
const Item = preload("Item.tscn")

onready var Map = $World/Map
onready var MoveController = $MoveController
onready var FightingController = $FightingController
onready var Player = $World/Creatures/Player
onready var Inventory = $GUI/InventoryBG/Inventory
onready var Items = $World/Items

# Called when the node enters the scene tree for the first time.
func _ready():
	Player.idx = CONSTANTS.PLAYER_START_IDX
	var item = Item.instance()
	item.init("stick") # not _ready() for scene yet, not part of the root scene tree, still 'orphan' until I '.add_child()'
	Inventory.addItem(item) # GUI render
	Items.add_child(item) # WORLD render // DEBUG
	
func _process(delta):
	var moveRequestVelocity = Player.InputHandler()
	
	if moveRequestVelocity.length() != 0: # GAME TICK
		MoveController.move(Map, Player, moveRequestVelocity)
