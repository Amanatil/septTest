extends Node2D

@onready var cam: Camera2D = $"../Node2D"
@onready var bg: TextureRect = $"../TextureRect"

func _draw():
	if cam == null:
		return
	
	var viewport_size = get_viewport_rect().size
	var top_left = cam.global_position - (viewport_size * cam.zoom * 0.5)
	var rect_size = viewport_size * cam.zoom
	
	draw_rect(Rect2(top_left, rect_size), Color(1, 0, 0, 0.2), false, 2)
	
func _process(_delta):
	queue_redraw()
