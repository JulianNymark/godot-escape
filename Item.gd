extends Node2D

onready var Sprite = $Sprite

var textureToSet = null
var idx = null

func init(texture):
	self.textureToSet = texture

func _ready():
	Sprite.texture = textureToSet
