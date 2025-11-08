extends Container

func _on_main_game_ended(rotation_count: float) -> void:
	$ResultsLabel.text = "YOUR ROTATION COUNT: %.3f" % [rotation_count];
	self.visible = true;
