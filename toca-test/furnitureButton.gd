extends Button

var originalScale = scale

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		GlobalStateManager.setFurnitureMode(true)
		#print("furniture mode is ON")
	else:
		GlobalStateManager.setFurnitureMode(false)
		#print("furniture mode is OFF")
	
	animate()

func animate():
	# Create a new tween every time you press
	var tween = create_tween()
	# Shrink, then expand back
	tween.tween_property(self, "scale", Vector2(originalScale*0.8), 0.1)
	tween.tween_property(self, "scale", Vector2(originalScale), 0.1)
