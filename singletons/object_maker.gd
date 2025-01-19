extends Node


enum BULLET_KEY {PLAYER, ENEMY}
enum SCENE_KEY {EXPLOSION, PICKUP}

const BULLETS = {
	BULLET_KEY.PLAYER: preload("res://bullets/bullet_player/bullet_player.tscn"),
	BULLET_KEY.ENEMY: preload("res://bullets/bullet_enemy/bullet_enemy.tscn")
}

const SIMPLE_SCENES = {
	SCENE_KEY.EXPLOSION: preload("res://enemy_explosion/enemy_explosion.tscn"),
	SCENE_KEY.PICKUP: preload("res://fruit_pick_up/fruit_pick_up.tscn")
}


func add_child_deferred(child_to_add) -> void:
	get_tree().root.add_child(child_to_add)


func call_add_child(child_to_add) -> void:
	call_deferred("add_child_deferred", child_to_add)


func create_bullet(direction: Vector2, speed: float, life_span: float, key: BULLET_KEY, start_pos: Vector2) -> void:
	var new_b = BULLETS[key].instantiate()
	new_b.setup(direction, life_span, speed)
	new_b.global_position = start_pos
	call_add_child(new_b)


func create_simple_scene(start_pos: Vector2, key: SCENE_KEY) -> void:
	var new_scene = SIMPLE_SCENES[key].instantiate()
	new_scene.global_position = start_pos
	call_add_child(new_scene)
