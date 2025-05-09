extends Control

@onready var hb_heart = $MC/HB/HBHeart
@onready var score_label = $MC/HB/ScoreLabel
@onready var color_rect = $ColorRect
@onready var vb_level_complete = $ColorRect/VBLevelComplete
@onready var vb_game_over = $ColorRect/VBGameOver
@onready var sound = $Sound
@onready var continue_timer = $ContinueTimer


var _hearts: Array
var _can_continue: bool = false

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


func _process(delta) -> void:
	if _can_continue and Input.is_action_just_pressed("jump"):
		if vb_game_over.visible == true:
			GameManager.load_main_scene()
		else:
			GameManager.load_next_level_scene()


func on_player_hit(lives: int) -> void:
	if lives < 0:
		return

	for life in range(_hearts.size()):
		_hearts[life].visible = lives > life


func show_hud() -> void:
	color_rect.show()
	continue_timer.start()


func on_game_over() -> void:
	show_hud()
	vb_game_over.show()


func on_game_win() -> void:
	show_hud()
	vb_level_complete.show()
	sound.play()
	

func on_score_updated(score: int) -> void:
	score_label.text = "%05d" % score # is 00000


func _on_continue_timer_timeout():
	_can_continue = true
