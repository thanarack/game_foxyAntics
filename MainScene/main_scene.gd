extends Control

const HIGH_SCORE_LABEL = preload("res://HighScoreLabel/high_score_label.tscn")


@onready var grid_container = $MarginContainer/GridContainer


func _ready():
	set_scores()


func _process(delta) -> void:
	if Input.is_action_just_pressed("jump"):
		GameManager.load_next_level_scene()


func set_scores() -> void:
	for c in grid_container.get_children():
		grid_container.remove_child(c)

	for s in ScoreManager.get_score_history():
		var lb: Label = HIGH_SCORE_LABEL.instantiate()
		lb.text = "%04d" % s
		grid_container.add_child(lb)
