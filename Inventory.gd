extends GridContainer

const limit = 20

var items = []

func addItem(item):
	print("item: ", item)
	if len(items) >= limit:
		print("inventory full")
		return
	
	var button = TextureButton.new()
	button.texture_normal = item.textureToSet
		
	var metaItem = {
		"item" : item, # ref to "real" item in world (Node2D)
		"button" : button, # ref to alter / remove GUI button
	}
	
	items.append(metaItem) # internal data ref
	self.add_child(button) # render in GUI
