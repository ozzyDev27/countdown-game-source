extends ShapeCast2D

func is_clear(area: Vector2):
	position = area
	force_shapecast_update()
	return get_collision_count() == 0

func flash():
	$Sprite2D.visible = true
	await get_tree().create_timer(0.2).timeout # waits for .2 seconds
	$Sprite2D.visible = false
