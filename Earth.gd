extends Node2D

const Rock = preload("Terrain/Rock.tscn")
const Grass = preload("Terrain/Grass.tscn")
const NoTexture = preload("Terrain/NoTexture.tscn")

const CONSTANTS = preload("constants.gd")
const DIM = Vector2(10,10)

onready var Map = $Map
onready var Creatures = $Creatures

var mapData = null

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	mapData = generateMapBlueprint(DIM)
	instantiateTerrain(mapData)
	instantiateCreatures()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# 2d array of strings that define which Terrain blocks to instantiate
func generateMapBlueprint(dimensions):
	var generated = []
	var toAdd = null
	for i in range(dimensions.y):
		toAdd = []
		for l in range(dimensions.x):
			if randf() > 0.9:
				toAdd.append({"items": [], "creature": null, "terrain": "Rock"})
			else:
				toAdd.append({"items": [], "creature": null, "terrain": "Grass"})
		generated.append(toAdd)
	
	return generated

func instantiateTerrain(terrainBlueprint):
	
	for y in range(len(terrainBlueprint)):
		for x in range(len(terrainBlueprint[0])):
			
			var node = null
			if terrainBlueprint[y][x].terrain == "Rock":
				node = Rock.instance()
			elif terrainBlueprint[y][x].terrain == "Grass":
				node = Grass.instance()
			else:
				node = NoTexture.instance()
			node.position = Vector2(x, y) * CONSTANTS.GRID_SIZE
			self.Map.add_child(node)
			
func instantiateCreatures():
	for i in range(DIM.y):
		for l in range(DIM.x):
			if randf() >= 0.7:
				Creatures.spawnCreature(self, "bat", Vector2(l, i))

func isImpassable(checkIdx) -> bool:
	var tileData = self.mapData[checkIdx.y][checkIdx.x]
	if tileData.terrain == "Rock":
		return true
	
	return false

func isOutOfBounds(idx: Vector2) -> bool:
	if idx.x < 0 or idx.x >= self.DIM.x:
		return true
	if idx.y < 0 or idx.y >= self.DIM.y:
		return true
	return false

func isCreature(idx: Vector2) -> bool:
	if self.mapData[idx.y][idx.x].creature:
		return true
	return false
