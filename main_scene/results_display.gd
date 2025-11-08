extends Container

func _on_main_game_ended(rotation_count: float) -> void:
	$ResultsLabel.text = "YOUR ROTATION COUNT: %.3f in %.0fs" % [rotation_count, 20];
	self.visible = true;
