extends GridContainer

const limit = 20

var items = []

func addItem(item):
	if self.isFull():
		return null
	
	var button = TextureButton.new()
	button.texture_normal = item.textureToSet
		
	var metaItem = {
		"item" : item, # ref to "real" item in world (Node2D)
		"button" : button, # ref to alter / remove GUI button
	}
	
	items.append(metaItem) # internal data ref
	self.add_child(button) # render in GUI

func removeLastItem():
	if self.isEmpty():
		return null
	var metaItem = self.items.pop_back()
	self.remove_child(metaItem.button)
	return metaItem.item
	
func isFull() -> bool:
	return len(items) >= limit
	
func isEmpty() -> bool:
	return len(items) <= 0
