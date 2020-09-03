extends Node2D

const MoveController = preload("MoveController.gd")
const Item = preload("Item.tscn")

const ItemTextures = {}

static func loadTexture(pngString):
	ItemTextures[pngString] = load("res://sprites/items/%s.png" % pngString)

const itemStrings = [
	"stick", "spellbook", "map", "magnet", "flashlight",
	"wizard_hat", "wizard_staff", "lantern", "bagpack", "magic_loaf_slice"
]

func _ready():
	for itemString in itemStrings:
		loadTexture(itemString)

func spawnRandomItem(idx):
	var rIdx = randi() % len(itemStrings)
	var item = Item.instance()
	item.init(self.ItemTextures[itemStrings[rIdx]])
	MoveController.setPos(item, idx)
	return item
