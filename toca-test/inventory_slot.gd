extends Control

@onready var icon_rect: TextureRect = $ItemIcon
@onready var count_label: Label = $CountLabel

var packed_scene: ItemResource = null

func set_item(packed: ItemResource, texture: Texture2D, count: int) -> void:
	packed_scene = packed
	icon_rect.texture = texture
	icon_rect.visible = texture != null
	if count > 1:
		count_label.text = str(count)
		count_label.visible = true
	else:
		count_label.text = ""
		count_label.visible = false

func clear_item() -> void:
	packed_scene = null
	icon_rect.texture = null
	icon_rect.visible = false
	count_label.text = ""
	count_label.visible = false

func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left click") and packed_scene != null:
		var camera = get_viewport().get_camera_2d()
		if camera:
			var drop_pos = camera.global_position
			InventoryManager.drop_item(packed_scene, drop_pos)
			get_parent().get_parent().refresh_inventory()
