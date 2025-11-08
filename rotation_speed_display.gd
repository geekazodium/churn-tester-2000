extends Label

@export var accuracy: float = 20;

const RAD_PER_SEC_TO_RPS: float = 1 / (2 * PI); #* 60;

func _on_reel_input_circle_angular_v_updated(velocity: float) -> void:
	var rotation_v: float = roundf(velocity * RAD_PER_SEC_TO_RPS * accuracy) / accuracy;
	self.text = "rotations per second: %.2f" % [rotation_v];
