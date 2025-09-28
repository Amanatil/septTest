extends Node

signal inventory_changed

# key: ItemResource, value: {"count": int, "node": Node2D}
var inventory := {} 

# Add a Node2D item to inventory
func add_item(item_node: Node2D) -> void:
	var res = item_node.item_resource
	if inventory.has(res):
		inventory[res]["count"] += 1
	else:
		inventory[res] = {"count": 1, "node": item_node}
	inventory_changed.emit()

# Remove an item resource from inventory
func remove_item(item_resource: ItemResource) -> void:
	if inventory.has(item_resource):
		var entry = inventory[item_resource]
		entry["count"] -= 1
		if entry["count"] <= 0:
			inventory.erase(item_resource)
		inventory_changed.emit()

# Retrieve the dictionary entry for a resource
func get_entry(item_resource: ItemResource) -> Dictionary:
	if inventory.has(item_resource):
		return inventory[item_resource]
	return {}  # return empty dict instead of null for type safety

# Drop an item back into the world
func drop_item(item_resource: ItemResource, position: Vector2) -> void:
	var entry = get_entry(item_resource)
	if entry.has("node") and entry["node"]:
		entry["node"].drop_item(position)
	remove_item(item_resource)

# Getter for the inventory dictionary, used by Inventory UI
func get_items() -> Dictionary:
	return inventory
