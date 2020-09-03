extends Node

const CONSTANTS = preload("constants.gd")
	
# direction must be an _index_ vector containing only 0 or 1
func move(map, movable, direction: Vector2):
	var currIdx = movable.idx
	var nextIdx = movable.idx + direction
	
	if map.isOutOfBounds(nextIdx):
		return
	
	if map.isImpassable(nextIdx):
		return
		
	setPos(movable, nextIdx)

static func setPos(movable, nextIdx):
	movable.idx = nextIdx # index
	movable.position = movable.idx * CONSTANTS.GRID_SIZE # render
