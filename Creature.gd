extends Node2D

onready var Sprite = $Sprite

var textureToSet = null
var idx = null
var creatureName = null
var health = 1
var strength = 0
var armor = 0


func init(creatureString, idx=Vector2()):
	self.creatureName = creatureString
	self.idx = idx

func _ready():
	Sprite.texture = textureToSet
