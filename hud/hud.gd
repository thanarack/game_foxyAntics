extends Control

@onready var hb_heart = $MC/HB/HBHeart
@onready var score_label = $MC/HB/ScoreLabel
@onready var color_rect = $ColorRect
@onready var vb_level_complete = $ColorRect/VBLevelComplete
@onready var vb_game_over = $ColorRect/VBGameOver


var _hearts: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Hud Ready")
	_hearts = hb_heart.get_children()
	SignalManager.on_player_hit.connect(on_player_hit)
	SignalManager.on_player_started.connect(on_player_hit)


func on_player_hit(lives: int) -> void:
	if lives < 0:
		return

	for life in range(_hearts.size()):
		_hearts[life].visible = lives > life
