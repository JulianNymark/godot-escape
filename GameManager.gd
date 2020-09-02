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
	var grabRequest = Player.DEBUG_GrabHandler()
	
	if moveRequestVelocity.length() != 0: # GAME TICK
		MoveController.move(Map, Player, moveRequestVelocity)
	
	if spawnRequest:
		spawnItem(Items, Map, "stick", Vector2(Player.idx))
	if grabRequest:
		grabItem(Vector2(Player.idx))

# wip move InventoryController?
func spawnItem(Items, Map, itemString, idx):
	var item = Item.instance()
	item.init(itemString) # not _ready() for scene yet, not part of the root scene tree, still 'orphan' until I '.add_child()'
	MoveController.setPos(item, idx)
	# Inventory.addItem(item) # GUI render
	Map.mapData[idx.y][idx.x].items.append(item) # add to mapdata
	Items.add_child(item) # WORLD render // DEBUG
	
# WIP move InventoryController
func grabItem(location: Vector2):
	var itemsAtFeet = Map.mapData[location.y][location.x].items
	if len(itemsAtFeet) > 0:
		var item = itemsAtFeet.pop_back() # remove from mapdata
		Items.remove_child(item)
		Inventory.addItem(item)
		
# WIP move: InventoryController
func dropItem():
	pass
