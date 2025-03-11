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
	on_score_updated(ScoreManager.get_score())
	_hearts = hb_heart.get_children()
	SignalManager.on_player_hit.connect(on_player_hit)
	SignalManager.on_player_started.connect(on_player_hit)
	SignalManager.on_game_over.connect(on_game_over)
	SignalManager.on_score_updated.connect(on_score_updated)
	SignalManager.on_game_win.connect(on_game_win)


func on_player_hit(lives: int) -> void:
	if lives < 0:
		return

	for life in range(_hearts.size()):
		_hearts[life].visible = lives > life


func show_hud() -> void:
	color_rect.show()


func on_game_over() -> void:
	show_hud()
	vb_level_complete.show()


func on_game_win() -> void:
	show_hud()
	vb_level_complete.show()


func on_score_updated(score: int) -> void:
	score_label.text = "%05d" % score # is 00000
