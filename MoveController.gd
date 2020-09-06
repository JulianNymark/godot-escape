extends Node

const CONSTANTS = preload("constants.gd")
	
# direction must be an _index_ vector containing only 0 or 1
static func move(Earth, movable, direction: Vector2):
	var nextIdx = movable.idx + direction
	
	if Earth.isOutOfBounds(nextIdx):
		return
	
	if Earth.isImpassable(nextIdx):
		return
		
	setPos(movable, nextIdx)

static func setPos(movable, nextIdx):
	movable.idx = nextIdx
	movable.position = movable.idx * CONSTANTS.GRID_SIZE # render
