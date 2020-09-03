extends Node

const Item = preload("Item.tscn")

# DEBUG
func spawnItem(MoveController, Map, Items, itemString, idx: Vector2):
	var item = Item.instance()
	item.init(itemString) # not _ready() for scene yet, not part of the root scene tree, still 'orphan' until I '.add_child()'
	MoveController.setPos(item, idx)
	Map.mapData[idx.y][idx.x].items.append(item) # add to mapdata
	Items.add_child(item) # WORLD render
	
func grabItem(Inventory, Map, Items, idx: Vector2):
	var itemsAtFeet = Map.mapData[idx.y][idx.x].items
	if len(itemsAtFeet) > 0:
		var item = itemsAtFeet.pop_back() # remove from mapdata
		if Inventory.isFull():
			print("your inventory is full")
			return
		Items.remove_child(item) # remove from world render
		Inventory.addItem(item) # add to Inv (add to inv data + inv render)
	else:
		print("you grab at the empty air")
func dropItem(Inventory, MoveController, Map, Items, idx: Vector2):
	if Inventory.isEmpty():
		print("your inventory is empty")
		return
	var item = Inventory.removeLastItem()
	MoveController.setPos(item, idx)
	Map.mapData[idx.y][idx.x].items.append(item) # add to mapdata
	Items.add_child(item) # WORLD render