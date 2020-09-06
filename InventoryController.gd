extends Node

# DEBUG
func spawnItem(MoveController, Earth, Items, itemString, idx: Vector2):
	var item = Items.spawnRandomItem(idx)
	Earth.mapData[idx.y][idx.x].items.append(item) # add to mapdata
	Items.add_child(item) # WORLD render
	
func grabItem(Inventory, Earth, Items, idx: Vector2):
	var itemsAtFeet = Earth.mapData[idx.y][idx.x].items
	if len(itemsAtFeet) > 0:
		var item = itemsAtFeet.pop_back() # remove from mapdata
		if Inventory.isFull():
			print("your inventory is full")
			return
		Items.remove_child(item) # remove from world render
		Inventory.addItem(item) # add to Inv (add to inv data + inv render)
	else:
		print("you grab at the empty air")
func dropItem(Inventory, MoveController, Earth, Items, idx: Vector2):
	if Inventory.isEmpty():
		print("your inventory is empty")
		return
	var item = Inventory.removeLastItem()
	MoveController.setPos(item, idx)
	Earth.mapData[idx.y][idx.x].items.append(item) # add to mapdata
	Items.add_child(item) # WORLD render
