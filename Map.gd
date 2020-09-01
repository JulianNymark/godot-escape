extends YSort

const Rock = preload("Terrain/Rock.tscn")
const Grass = preload("Terrain/Grass.tscn")
const NoTexture = preload("Terrain/NoTexture.tscn")

const CONSTANTS = preload("constants.gd")
const DIM = Vector2(10,10)

var mapData = null

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	mapData = generateMapBlueprint(DIM)
	instantiateTerrain(mapData)

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
				toAdd.append("Rock")
			else:
				toAdd.append("Grass")
		generated.append(toAdd)
	
	return generated

func instantiateTerrain(terrainBlueprint):
	
	for y in range(len(terrainBlueprint)):
		for x in range(len(terrainBlueprint[0])):
			
			var node = null
			if terrainBlueprint[y][x] == "Rock":
				node = Rock.instance()
			elif terrainBlueprint[y][x] == "Grass":
				node = Grass.instance()
			else:
				node = NoTexture.instance()
			node.position = Vector2(x, y) * CONSTANTS.GRID_SIZE
			self.add_child(node)
