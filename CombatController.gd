extends Node

func attack(PlayerHealth, Earth, Creatures, Attacker, idx):
	var target = Earth.mapData[idx.y][idx.x].creature
	var isPlayerAttacking = Attacker.creatureName == "Player"
	var isPlayerTarget = target.creatureName == "Player"
	
	var strikeAccuracy = randf()
	var strikeStrength = Attacker.strength
	
	var critical = false
	var miss = false
	var grazing = false
	
	if strikeAccuracy >= 0.9:
		critical = true
		strikeStrength = ceil(2 * strikeStrength)
	elif strikeAccuracy >= 0.66:
		strikeStrength = ceil(1 * strikeStrength)
	elif strikeAccuracy >= 0.33:
		grazing = true
		strikeStrength = ceil(0.5 * strikeStrength)
	else:
		miss = true
		strikeStrength = 0
		
	var armorReduction = 0
	if target.armor:
		armorReduction = (randi() % target.armor) + 1
		
	var damage = 0
	if !miss:
		damage = (randi() % int(strikeStrength)) + 1
		damage -= armorReduction
	
	if damage < 0:
		damage = 0
	
	target.health = target.health - damage
	
	if isPlayerAttacking:
		var hitString = "strike"
		if critical:
			hitString = "DEMOLISH"
		if miss:
			hitString = "miss"
		if grazing:
			hitString = "graze"
		print("you %s the %s for %d damage!" % [hitString, target.creatureName, damage])
	elif isPlayerTarget:
		var hitString = "strikes"
		if critical:
			hitString = "DEMOLISHES"
		if miss:
			hitString = "misses"
		if grazing:
			hitString = "grazes"
		print("%s %s you for %d damage!" % [target.creatureName, hitString, damage])
	else:
		var hitString = "strikes"
		if critical:
			hitString = "DEMOLISHES"
		if miss:
			hitString = "misses"
		if grazing:
			hitString = "grazes"
		print("%s %s the %s for %d damage!" % [Attacker.creatureName, hitString, target.creatureName, damage])


	if isPlayerTarget:
		PlayerHealth.setHealth(target.health)

	if target.health <= 0:
		Creatures.removeCreature(Earth, target.idx)
		print("the %s is killed" % target.creatureName)
