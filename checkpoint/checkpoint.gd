extends Area2D

const TRIGGER_CONDITION: String = "parameters/conditions/on_trigger"

@onready var animation_tree = $AnimationTree
@onready var sound = $Sound
@onready var sprite_2d = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_boss_killed.connect(on_boss_killed)


func on_boss_killed(_p: int) -> void:
	sprite_2d.show()
	animation_tree[TRIGGER_CONDITION] = true
	monitoring = true
	SoundManager.play_clip(sound, SoundManager.SOUND_CHECKPOINT)


func _on_area_entered(area):
	print("level complete")
	SoundManager.play_clip(sound, SoundManager.SOUND_WIN)
	SignalManager.on_game_win.emit()
