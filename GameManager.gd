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
	var dropRequest = Player.DEBUG_DropHandler()
	
	if moveRequestVelocity.length() != 0: # GAME TICK
		MoveController.move(Map, Player, moveRequestVelocity)
	
	if spawnRequest:
		spawnItem(Items, Map, "stick", Player.idx)
	if grabRequest:
		grabItem(Items, Map, Player.idx)
	if dropRequest:
		dropItem()

# wip move InventoryController? // DEBUG
func spawnItem(Items, Map, itemString, idx):
	var item = Item.instance()
	item.init(itemString) # not _ready() for scene yet, not part of the root scene tree, still 'orphan' until I '.add_child()'
	MoveController.setPos(item, idx)
	Map.mapData[idx.y][idx.x].items.append(item) # add to mapdata
	Items.add_child(item) # WORLD render
	
# WIP move InventoryController
func grabItem(Items, Map, locationIdx: Vector2):
	var itemsAtFeet = Map.mapData[locationIdx.y][locationIdx.x].items
	if len(itemsAtFeet) > 0:
		var item = itemsAtFeet.pop_back() # remove from mapdata
		Items.remove_child(item) # remove from world render
		Inventory.addItem(item) # add to Inv (add to inv data + inv render)
		
# WIP move: InventoryController
func dropItem():
	var item = Inventory.removeLastItem()
	var idx = Player.idx
	MoveController.setPos(item, idx)
	Map.mapData[idx.y][idx.x].items.append(item) # add to mapdata
	Items.add_child(item) # WORLD render
