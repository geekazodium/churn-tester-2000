extends Node2D
class_name ReelInputCircle

var last_input_direction: Vector2 = Vector2.UP;
@export var delta_scale: float = 8;
var angle: float = 0;
var rotate_count: int = 0;

@export var delta_v_change_rate: float = 3;
var rolling_average_delta_v: float;

signal rotation_completed();
signal angular_v_updated(velocity: float);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.disable();

func disable() -> void:
	self.visible = false;
	self.set_process(false);

func enable() -> void:
	self.visible = true;
	self.set_process(true);
	self.angle = 0;
	self.rolling_average_delta_v = 0;
	self.last_input_direction = Vector2.UP;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var initial_dir: Vector2 = self.last_input_direction;
	var input_vec: Vector2 = self.get_input_vec().normalized();
	if input_vec == Vector2.ZERO || input_vec.dot(initial_dir) <= -.9:
		input_vec = initial_dir;
	var scale_fac: float = exp(self.delta_scale * -delta);
	self.last_input_direction = self.last_input_direction.slerp(
		input_vec,
		1 - scale_fac
	);
	
	$Direction.position = (
		self.last_input_direction *
		Vector2(300,-300)
	);
	
	var delta_angle: float = get_angle_diff(self.last_input_direction, initial_dir);
	self.angle += delta_angle;
	
	var roll_avg_scale_fac: float = exp(-delta * self.delta_v_change_rate);
	self.rolling_average_delta_v = lerpf(
		delta_angle / delta,
		self.rolling_average_delta_v,
		roll_avg_scale_fac
	);
	self.angular_v_updated.emit(self.rolling_average_delta_v);
	if self.angle > PI * 2:
		self.angle -= PI * 2;
		self.rotate_count += 1;
		self.rotation_completed.emit();
	if self.angle < -PI * 2:
		self.angle += PI * 2;
		self.rotate_count += 1;
		self.rotation_completed.emit();

func get_input_vec() -> Vector2:
	var input_vec: Vector2 = Vector2(
		Input.get_axis("left", "right"), 
		Input.get_axis("down","up")
	);
	if input_vec.length_squared() > 1:
		return input_vec.normalized();
	return input_vec;

#region Rotation Utility Functions
static func get_angle_diff_safe(vec1: Vector2, vec2: Vector2) -> float:
	return get_angle_diff(vec1.normalized(), vec2.normalized());

## ONLY INPUT NORMALIZED VECTORS, DO NOT, AND I STRESS THIS
## DO NOT INPUT NON-NORMALIZED NON-ZERO VECTORS, YOU WILL MAKE
## THIS FUNCTION CRASH AND BURN
static func get_angle_diff(vec1: Vector2, vec2: Vector2) -> float:
	var dot_res: float = rotate_90(vec1).dot(vec2);
	return asin(dot_res);

static func rotate_90(vec: Vector2) -> Vector2:
	return Vector2(-vec.y,vec.x);
#endregion
