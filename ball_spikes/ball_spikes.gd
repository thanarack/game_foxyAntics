extends PathFollow2D

@export var speed: float = 0.14
@onready var animation_player = $Hitbox/AnimationPlayer


func _ready():
	SignalManager.on_game_over.connect(on_game_over)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress_ratio = progress_ratio + delta * speed


func on_game_over() -> void:
	animation_player.stop()
	set_process(false)
