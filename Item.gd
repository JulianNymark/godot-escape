extends Node2D

onready var Sprite = $Sprite

var textureToSet = null
var idx = null

const ItemTextures = {
	"stick": preload("res://sprites/items/stick.png")
}

func init(itemString):
	self.textureToSet = ItemTextures[itemString]

func _ready():
	Sprite.texture = textureToSet
