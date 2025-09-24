extends Camera2D

# Boundaries for X movement
@export var min_x: float = -500.0
@export var max_x: float = 500.0

# Sensitivity for mouse drag
@export var drag_sensitivity: float = 1.0

var dragging: bool = false
var last_mouse_pos: Vector2

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				last_mouse_pos = event.position
			else:
				dragging = false
	
	elif event is InputEventMouseMotion and dragging:
		var delta = event.position - last_mouse_pos
		position.x -= delta.x * drag_sensitivity
		position.x = clamp(position.x, min_x, max_x)
		last_mouse_pos = event.position
