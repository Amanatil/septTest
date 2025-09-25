extends Node2D

@export var item_resource: ItemResource
@onready var sprite: Sprite2D = $Sprite2D

func _ready():
	if item_resource:
		sprite.texture = item_resource.texture
		update_glow(item_resource.furnitureGlow)
	
	GlobalStateManager.furnitureModeSignal.connect(toggle_furniture_mode)

func update_glow(on: bool):
	if sprite.material and sprite.material is ShaderMaterial:
		sprite.material.set_shader_parameter("show_outline", on)
		print("GLOWING")

func toggle_furniture_mode(enabled: bool):
	if item_resource.furniture_tag == ItemResource.furnitureTag.Furniture:
		update_glow(enabled)
	else:
		update_glow(false)
