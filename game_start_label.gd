extends Label

@export var start_timer: Timer;

func _ready() -> void:
	self.start_timer.timeout.connect(self._game_start);

func _process(_delta: float) -> void:
	if self.start_timer.time_left > 0:
		self.text = "%.0f" % [ceil(self.start_timer.time_left)];

func _game_start() -> void:
	self.text = "START!";
	await get_tree().create_timer(1).timeout;
	self.visible = false;
