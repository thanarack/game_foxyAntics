extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var life_timer = $LifeTimer

const FRUITS: Array = ["melon", "banana", "cherry", "kiwi"]
const GRAVITY: float = 120.0
const JUMP: float = -80.0
const POINT: int = 2

var _start_y: float
var _speed_y: float = JUMP
var _stopped: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	_start_y = global_position.y
	animated_sprite_2d.play(FRUITS.pick_random())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _stopped == true:
		return

	# gravity is pulling the fruit down, so we move the fruit down by
	# the current speed (which is negative, so it moves up) times delta
	# (which is the time since the last frame). Then we add the gravity
	# times delta to the speed, to make the fruit accelerate down.
	#
	# When the fruit hits the ground (i.e., its position is greater than
	# the start y), we set the flag to stop updating
	position.y += _speed_y * delta
	_speed_y += GRAVITY * delta

	if global_position.y > _start_y:
		_stopped = true


func kill_me() -> void:
	set_process(false)
	hide()
	queue_free()


func _on_life_timer_timeout():
	kill_me()


func _on_area_entered(area):
	print("Pickup collected")
	SignalManager.on_pickup_hit.emit(POINT)
	kill_me()
