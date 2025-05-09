extends Node

const MAIN_SCENE = preload("res://MainScene/main_scene.tscn")
const TOTAL_LEVELS: int = 2

var _level_senes: Dictionary = {}
var _current_level: int = 0

const GROUP_PLAYER: String = "player"
const GROUP_MOVEABLES: String = "moveables"


func _ready() -> void:
	for ln in range(1, TOTAL_LEVELS + 1):
		var level_scene: PackedScene = load("res://level_%d/level_base.tscn" % [ln])
		_level_senes[ln] = level_scene


func load_main_scene() -> void:
	_current_level = 0
	ScoreManager.reset_score()
	get_tree().change_scene_to_packed(MAIN_SCENE)


func load_next_level_scene() -> void:
	set_next_level()
	get_tree().change_scene_to_packed(_level_senes[_current_level])


func set_next_level() -> void:
	_current_level += 1
	if _current_level > TOTAL_LEVELS:
		_current_level = 1
