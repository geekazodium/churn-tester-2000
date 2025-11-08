extends Button

func _pressed() -> void:
	self.get_tree().reload_current_scene();
