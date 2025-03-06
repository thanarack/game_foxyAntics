extends Node2D

@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_game_over.connect(on_game_over)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	pass

func on_game_over() -> void:
	for mv in get_tree().get_nodes_in_group(GameManager.GROUP_MOVEABLES):
		mv.set_process(false)
		mv.set_physics_process(false)
		print(mv)
