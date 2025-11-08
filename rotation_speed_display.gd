extends Label

@export var use_per_sec_toggle: CheckButton;

var use_per_second: bool:
	get:
		return use_per_sec_toggle.button_pressed;

const RAD_PER_SEC_TO_RPS: float = 1 / (2 * PI);

func _on_reel_input_circle_angular_v_updated(velocity: float) -> void:
	var scale_fac: float = RAD_PER_SEC_TO_RPS * (1 if use_per_second else 60);
	var rotation_v: float = velocity * scale_fac;
	var fmt: Array[String];
	if use_per_second:
		fmt = ["second", "%.2f"];
	else:
		fmt = ["minute", "%.0f"];
	self.text = ("rotations per %s: %s" % fmt) % [rotation_v];
