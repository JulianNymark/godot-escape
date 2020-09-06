extends Node

const CONSTANTS = preload("constants.gd")
	
# direction must be an _index_ vector containing only 0 or 1
static func move(PlayerHealth, Earth, Creatures, CombatController, movable, direction: Vector2):
	var nextIdx = movable.idx + direction
	
	if Earth.isOutOfBounds(nextIdx):
		return
	
	if Earth.isImpassable(nextIdx):
		return
	
	if Earth.isCreature(nextIdx):
		CombatController.attack(PlayerHealth, Earth, Creatures, movable, nextIdx)
		return
		
	setPos(Earth, movable, nextIdx)

# used to both initialize & to update idx!
static func setPos(Earth, movable, nextIdx):
	if (movable.idx):
		Earth.mapData[movable.idx.y][movable.idx.x].creature = null
	movable.idx = nextIdx
	movable.position = movable.idx * CONSTANTS.GRID_SIZE # render
	Earth.mapData[movable.idx.y][movable.idx.x].creature = movable
