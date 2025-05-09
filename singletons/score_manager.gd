extends Node

const SCORE_FILE: String = "user://FoxySore.json"
const MAX_SCORES: int = 10


var _score: int = 5
var _score_history: Array = []

func _ready():
  SignalManager.on_enemy_hit.connect(update_score)
  SignalManager.on_pickup_hit.connect(update_score)
  SignalManager.on_game_over.connect(on_game_over)
  load_scores_history()


func get_score_history() -> Array[int]:
  var h: Array[int] = []
  for s in _score_history.slice(0, MAX_SCORES):
    if s.score != 0:
      h.push_back(int(s.score))

  return h


func compare_scores(a, b) -> int:
  return b.score < a.score


func save_scores() -> void:
  _score_history.sort_custom(compare_scores)
  var file = FileAccess.open(SCORE_FILE, FileAccess.WRITE)
  if file:
    file.store_string(JSON.stringify(_score_history.slice(0, MAX_SCORES)))
    file.close()

  print(_score_history)


func on_game_over() -> void:
  if _score > 0:
    _score_history.append({"score": _score})
    save_scores()


func load_scores_history() -> void:
  _score_history.clear()

  var file = FileAccess.open(SCORE_FILE, FileAccess.READ)
  if file:
    var text: String = file.get_as_text()
    if text and text.length() > 0:
      _score_history = JSON.parse_string(text)
    file.close()
  else:
    save_scores()

  _score_history.sort_custom(compare_scores)
  print(_score_history)


func update_score(p: int) -> void:
  print("update score", p)
  _score += p
  SignalManager.on_score_updated.emit(_score)


func reset_score() -> void:
  _score = 0


func get_score() -> int:
  return _score
