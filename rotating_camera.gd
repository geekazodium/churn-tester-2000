extends Camera2D

@onready var default_zoom: Vector2 = self.zoom;
@export var zoom_change: float = .5;

func _ready() -> void:
	self.ignore_rotation = false;

func _on_reel_input_circle_angular_v_updated(velocity: float) -> void:
	self.global_rotation_degrees = -sqrt(abs(velocity)) * sign(velocity);
	self.zoom = self.default_zoom * (1 + (1-exp(-abs(velocity) * .2)) * self.zoom_change);
