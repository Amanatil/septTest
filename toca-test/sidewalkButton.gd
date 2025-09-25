extends Button
var start = position

func _on_pressed() -> void:
	var tween = create_tween()
	tween.tween_property(self, "position", start + Vector2(5, 0), 0.05)
	tween.tween_property(self, "position", start - Vector2(5, 0), 0.05)
	tween.tween_property(self, "position", start + Vector2(5, 0), 0.05)
	tween.tween_property(self, "position", start - Vector2(5, 0), 0.05)
	tween.tween_property(self, "position", start, 0.05)
