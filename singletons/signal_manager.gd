extends Node

signal on_enemy_hit(point: int, enemy_position: Vector2)
signal on_pickup_hit(point: int)
signal on_boss_killed(point: int)
signal on_game_over
signal on_player_hit(lives: int)
