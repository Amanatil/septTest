extends Node2D

@export var item_resource: ItemResource
@onready var sprite: Sprite2D = $Sprite2D
@onready var collisionShape: CollisionShape2D = $Area2D/CollisionShape2D

# Dragging state
var dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO
var drag_started: bool = false

func _ready():
	if item_resource:
		sprite.texture = item_resource.texture
		
		if sprite.texture:
			if item_resource.size_tag == ItemResource.sizeTag.Small:
				var tex_size = sprite.texture.get_size()
				var scale_y = 200.0 / tex_size.y
				sprite.scale = Vector2(scale_y, scale_y)
				collisionShape.scale = Vector2(10.0, 10.0)
			else:
				var tex_size = sprite.texture.get_size()
				var scale_y = 600.0 / tex_size.y
				sprite.scale = Vector2(scale_y, scale_y)
				collisionShape.scale = Vector2(30.0, 30.0)
		
	if sprite.material and sprite.material is ShaderMaterial:
		sprite.material = (sprite.material as ShaderMaterial).duplicate(true) as ShaderMaterial

	update_glow_mode("", false)
	GlobalStateManager.furnitureModeSignal.connect(toggle_furniture_mode)
	GlobalStateManager.inventoryModeSignal.connect(toggle_inventory_mode)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left click"):
		if GlobalStateManager.furnitureMode and item_resource.furniture_tag == ItemResource.furnitureTag.Furniture:
			dragging = true
			drag_started = true
			GlobalStateManager.item_is_dragged = true
			drag_offset = global_position - get_global_mouse_position()
		elif GlobalStateManager.inventoryMode and item_resource.furniture_tag == ItemResource.furnitureTag.Not_Furniture:
			dragging = true
			drag_started = true
			GlobalStateManager.item_is_dragged = true
			drag_offset = global_position - get_global_mouse_position()

	if event.is_action_released("left click"):
		if dragging:
			dragging = false
			GlobalStateManager.item_is_dragged = false

			if drag_started and GlobalStateManager.inventoryMode and item_resource.furniture_tag == ItemResource.furnitureTag.Not_Furniture:
				InventoryManager.add_item(self)

				# Hide the node
				visible = false
				set_process(false)
				set_physics_process(false)
				collisionShape.disabled = true
				global_position = Vector2(-1000, -1000)
		drag_started = false

func drop_item(drop_position: Vector2) -> void:
	global_position = drop_position
	visible = true
	set_process(true)
	set_physics_process(true)
	collisionShape.disabled = false

func _process(_delta: float) -> void:
	if dragging:
		var mouse_pos = get_global_mouse_position()
		if drag_started and (mouse_pos - (global_position - drag_offset)).length() > 4:
			drag_started = false
		global_position = mouse_pos + drag_offset

func update_glow_mode(mode: String, enabled: bool, color: Color = Color(1,1,0,1)) -> void:
	if not item_resource or not sprite or not sprite.material or not sprite.material is ShaderMaterial:
		return
	var should_glow = false
	if mode == "furniture":
		should_glow = enabled and item_resource.furniture_tag == ItemResource.furnitureTag.Furniture
	elif mode == "inventory":
		should_glow = enabled and item_resource.furniture_tag == ItemResource.furnitureTag.Not_Furniture
	var mat := sprite.material as ShaderMaterial
	mat.set_shader_parameter("show_outline", should_glow)
	mat.set_shader_parameter("outline_color", color)

func toggle_furniture_mode(enabled: bool) -> void:
	update_glow_mode("furniture", enabled, Color(1,1,0,1))

func toggle_inventory_mode(enabled: bool) -> void:
	update_glow_mode("inventory", enabled, Color(0.2,0.8,1,1))
