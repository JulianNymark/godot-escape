extends GridContainer

const limit = 20

var items = []

func addItem(item):
	print("item: ", item)
	if len(items) >= limit:
		print("inventory full")
		return
	
	items.append(item)
	var button = TextureButton.new()
	button.texture_normal = item.textureToSet
	item.inventoryButton = button # WIP for easier removal from GUI later?
	self.add_child(button) # render in GUI
