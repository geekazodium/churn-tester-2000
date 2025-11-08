extends Label

@export var main: MainScene;
@export var game_time_left: Timer;

func _on_game_start() -> void:
	self.visible = true;

func _process(_delta: float) -> void:
	self.text = "time left: %.1fs \ncurrent_rotations: %.0f" % [self.game_time_left.time_left, self.main.rotate_count];
