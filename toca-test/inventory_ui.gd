extends Control

@onready var grid: GridContainer = $GridContainer
var slot_scene: PackedScene = preload("res://inventorySlot.tscn")

func _ready() -> void:
	# connect to inventory changes
	InventoryManager.inventory_changed.connect(refresh_inventory)
	refresh_inventory()

func refresh_inventory():
	var items = InventoryManager.get_items()
	var slots = grid.get_children()
	

	var i = 0
	for resource in items.keys():
		if i >= slots.size():
			break
		var slot: Control = slots[i]
		var tex = resource.texture
		var count = items[resource]["count"]
		slot.set_item(resource, tex, count)
		i += 1

	# clear unused slots
	for j in range(i, slots.size()):
		slots[j].clear_item()
