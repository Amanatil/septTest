extends Node

var furnitureMode = false
var inventoryMode = false
# signal for Furniture mode
# signal for Inventory mode

func setFurnitureMode(toggle:bool):
	if inventoryMode == true:
		print("Cannot Toggle Furniture Mode on while inventory mode is active")
		pass
	else:
		furnitureMode = toggle
		if toggle == true:
			print("Furniture Mode is on")
			# replace with signal
		elif toggle == false:
			print("Furniture Mode is off")
			# replace with signal
		pass

func setInventorymode(toggle:bool):
	if furnitureMode == true:
		print("Cannot Toggle Inventory Mode on while inventory mode is active")
		pass
	else:
		inventoryMode = toggle
		if inventoryMode == true:
			print("Inventory Mode is on")
			# replace with signal
		elif inventoryMode == false:
			print("Inventory Mode is off")
			# replace with signal
		pass
