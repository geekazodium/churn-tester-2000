extends Node2D
class_name MainScene

@export var reel_input_circle: ReelInputCircle;
var counting: bool = false;
var rotate_count: int = 0;

signal game_ended(rotation_count: float);

func _ready() -> void:
	self.reel_input_circle.enable();

func _start_game() -> void:
	self.reel_input_circle.enable();
	$GameEndTimer.start();
	self.reel_input_circle.rotation_completed.connect(self._rotation_completed);
	self.counting = true;
	self.rotate_count = 0;

func _rotation_completed() -> void:
	self.rotate_count += 1;

func _game_over() -> void:
	self.reel_input_circle.disable();
	var c: float = self.rotate_count;
	c += abs(self.reel_input_circle.angle / (PI * 2));
	self.game_ended.emit(c);
