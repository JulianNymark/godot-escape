extends ProgressBar

onready var MaxHealth = $PlayerHealthMax
onready var CurrHealth = $PlayerHealthCurr

var maxHealth = 100
var health = 100

func setHealth(value):
	health = value
	self.value = value
	CurrHealth.text = str(value)
	
func setMaxHealth(value):
	maxHealth = value
	self.max_value = value
	MaxHealth.text = str(value)
