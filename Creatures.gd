extends Node2D

const MoveController = preload("MoveController.gd")
const Creature = preload("Creature.tscn")

const creatureTextures = {}

static func loadTexture(pngString):
	creatureTextures[pngString] = load("res://sprites/creatures/%s.png" % pngString)

const creatureStrings = [
	"bat"
]

var creatureData = {
	"bat": {
		"health": 10,
		"strength": 5,
		"armor": 1
	}
}

func _ready():
	for creatureString in creatureStrings:
		loadTexture(creatureString)

func spawnCreature(Earth, creatureString, idx):
	var data = creatureData[creatureString]
	
	var creature = Creature.instance()
	creature.init(creatureString)
	creature.textureToSet = creatureTextures[creatureString]
	creature.health = data.health
	creature.strength = data.strength
	
	MoveController.setPos(Earth, creature, idx)
	Earth.mapData[idx.y][idx.x].creature = creature
	self.add_child(creature) # world render
	return creature

func removeCreature(Earth, idx):
	var creature = Earth.mapData[idx.y][idx.x].creature
	self.remove_child(creature)
	Earth.mapData[idx.y][idx.x].creature = null
	return creature
