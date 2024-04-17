extends Marker2D

@export var item: PackedScene
@export var random_on_screen = false

func spawn():
	for i in range(10):
		var test_pos = Vector2(randf(), randf()) * Vector2(1920, 1080)
		if not $"../CollisionCheck".is_clear(test_pos):
			continue
		var node = item.instantiate()
		node.global_position = test_pos
		print(node.global_position)
		$/root/Node2D.add_child(node)
		break
