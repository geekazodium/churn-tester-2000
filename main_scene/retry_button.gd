extends Button

@onready var default_text: String = self.text;

@export var hold_time: float = 0;
var current_hold_time: float = 0;

@export var grab_focus_when_vis: bool = false;

func _process(delta: float) -> void:
	if self.is_visible_in_tree() && self.grab_focus_when_vis:
		self.grab_focus();
	if self.button_pressed:
		if self.current_hold_time >= self.hold_time:
			self.get_tree().reload_current_scene();
			return;
		self.text = "hold" + ".".repeat(round(self.current_hold_time / self.hold_time * 4));
		self.current_hold_time += delta;
	else:
		self.text = self.default_text;
		self.current_hold_time = 0;
