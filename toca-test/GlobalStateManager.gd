extends Node

var furnitureMode = false
var inventoryMode = false
signal furnitureModeSignal(toggle)
signal inventoryModeSignal(toggle)

var item_is_dragged = false
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
			furnitureModeSignal.emit(toggle)
			# replace with signal
		elif toggle == false:
			furnitureModeSignal.emit(toggle)
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
			inventoryModeSignal.emit(toggle)
			print("Inventory Mode is on")
			# replace with signal
		elif inventoryMode == false:
			inventoryModeSignal.emit(toggle)
			print("Inventory Mode is off")
			# replace with signal
		pass
