extends Camera2D

# Inspector values
@export var bg: TextureRect
@export var drag_sensitivity: float = 1.0

# Internal
var dragging: bool = false
var last_mouse_pos: Vector2

@onready var cam: Camera2D = self
var min_x: float
var max_x: float

func _ready():
	if bg == null:
		push_error("Background TextureRect not assigned!")
		return

	# Get viewport size in pixels
	var viewport_size = get_viewport_rect().size
	var zoomed_viewport_width = viewport_size.x
	print("Viewport width: ", zoomed_viewport_width)
	# Background left and right edges in world coordinates
	var bg_left = bg.position.x
	var bg_right = bg.position.x + bg.size.x  # TextureRect uses rect_size for width/height
	print("left: ", bg_left)
	print("right ", bg_right)
	
	# Correctly compute horizontal camera limits
	# I honestly don't know why the extra 80 pixels is necessary here, but it is. Otherwise a grey border keeps showing
	min_x = bg_left + zoomed_viewport_width + 80.0
	max_x = bg_right - zoomed_viewport_width - 80.0 
	print("min X: ", min_x)
	print("max X: ", max_x)

	# Scale UI elements to match zoom
	update_ui_scale()


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		dragging = event.pressed
		if dragging:
			last_mouse_pos = event.position

	elif event is InputEventMouseMotion and dragging and GlobalStateManager.item_is_dragged == false:
		var delta = event.position - last_mouse_pos
		var new_x = position.x - delta.x * drag_sensitivity
		position.x = clamp(new_x, min_x, max_x)
		last_mouse_pos = event.position


func update_ui_scale():
	for ui_node in cam.get_children():
		if ui_node is Control:
			ui_node.scale = cam.zoom
