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
	MoveController.setPos(Player, CONSTANTS.PLAYER_START_IDX)
	
func _process(delta):
	var moveRequestVelocity = Player.MoveHandler()
	var spawnRequest = Player.DEBUG_SpawnHandler()
	
	if moveRequestVelocity.length() != 0: # GAME TICK
		MoveController.move(Map, Player, moveRequestVelocity)
	
	if spawnRequest:
		spawnItem(Items, "stick", Vector2(Player.idx))

# wip move InventoryController?
func spawnItem(Items, itemString, idx):
	var item = Item.instance()
	item.init(itemString) # not _ready() for scene yet, not part of the root scene tree, still 'orphan' until I '.add_child()'
	item.position = idx * CONSTANTS.GRID_SIZE
	# Inventory.addItem(item) # GUI render
	Items.add_child(item) # WORLD render // DEBUG
	
# WIP move InventoryController
func grabItem():
	pass
# WIP move: InventoryController
func dropItem():
	pass
