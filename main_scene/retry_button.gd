extends Button

@onready var default_text: String = self.text;

@export var hold_time: float = 0;
var current_hold_time: float = 0;

func _process(delta: float) -> void:
	if self.button_pressed:
		if self.current_hold_time >= self.hold_time:
			self.get_tree().reload_current_scene();
			return;
		self.text = "hold" + ".".repeat(round(self.current_hold_time / self.hold_time * 4));
		self.current_hold_time += delta;
	else:
		self.text = self.default_text;
		self.current_hold_time = 0;
