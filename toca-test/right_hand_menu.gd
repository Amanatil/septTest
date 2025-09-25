extends Button

var thisButton = self
#func toggled(toggled_on: bool):

func _on_toggled(toggled_on: bool) -> void:
	print("That tickles")
	if toggled_on == true:
		print("I'm toggled!")
		for child in thisButton.get_children():
			child.disabled = false
			child.visible = true
	else:
		print("I'm Un-toggled!")
		for child in thisButton.get_children():
			child.disabled = true
			child.visible = false
