@icon("res://icon.svg")
extends Resource

class_name ItemResource

# Base properties
@export var name: String = "New Item"
@export var texture: Texture2D

@export var furnitureGlow: bool = false
@export var inventoryGlow: bool = false

# Tags
enum sizeTag {Small, Large}
@export var size_tag: sizeTag = sizeTag.Small

enum furnitureTag {Not_Furniture, Furniture}
@export var furniture_tag: furnitureTag = furnitureTag.Not_Furniture
