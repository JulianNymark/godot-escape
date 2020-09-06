extends Node2D

onready var Sprite = $Sprite

var textureToSet = null
var idx = null

func init(texture, idx=Vector2()):
	self.textureToSet = texture
	self.idx = idx

func _ready():
	Sprite.texture = textureToSet
