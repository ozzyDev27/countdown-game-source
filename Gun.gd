extends Marker2D

@export var bullet: PackedScene

func shoot():
	print("Shooting")
	var node = bullet.instantiate()
	node.global_position = global_position
	node.linear_velocity = Vector2(500, 0).rotated(global_rotation)
	print(node.linear_velocity)
	$/root/Node2D.add_child(node)
