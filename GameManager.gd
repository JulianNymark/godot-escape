extends Node

const CONSTANTS = preload("constants.gd")

onready var MoveController = $MoveController
onready var CombatController = $CombatController
onready var InventoryController = $InventoryController
onready var Earth = $Earth
onready var Items = $Earth/Items
onready var Creatures = $Earth/Creatures
onready var Player = $Earth/Creatures/Player

onready var Inventory = $GUI/InventoryBG/Inventory
onready var PlayerHealth = $GUI/StatsBG/PlayerHealth

# Called when the node enters the scene tree for the first time.
func _ready():
	MoveController.setPos(Earth, Player, CONSTANTS.PLAYER_START_IDX)
	PlayerHealth.setMaxHealth(Player.health)
	PlayerHealth.setHealth(Player.health)
	
func _process(delta):
	var moveRequestVelocity = Player.MoveHandler()
	
	if moveRequestVelocity.length() != 0: # GAME TICK
		MoveController.move(PlayerHealth, Earth, Creatures, CombatController, Player, moveRequestVelocity)
		# for each creature, calculate intent & action
		var creatures = Creatures.get_children()
		creatures.remove(creatures.find(Player)) # only NPCs
		for creature in creatures:
			var xmove = (randi() % 3) - 1
			var ymove = (randi() % 3) - 1
			var moveTo = Vector2(xmove, ymove)
			if moveTo.length() <= 0:
				continue
			MoveController.move(PlayerHealth, Earth, Creatures, CombatController, creature, moveTo)
	
	if Player.DEBUG_SpawnHandler():
		InventoryController.spawnItem(Earth, Items, "stick", Player.idx)
	if Player.DEBUG_GrabHandler():
		InventoryController.grabItem(Inventory, Earth, Items, Player.idx)
	if Player.DEBUG_DropHandler():
		InventoryController.dropItem(Inventory, MoveController, Earth, Items, Player.idx)
	if Player.DEBUG_ExitHandler():
		get_tree().quit()
