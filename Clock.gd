extends CharacterBody2D

@export var speed = 250.0

func _ready():
	velocity = Vector2(speed, speed)

func _physics_process(delta):
	if get_last_slide_collision():
		var collision: KinematicCollision2D = get_last_slide_collision()
		if collision.get_collider():
			hit(collision.get_collider())
		velocity = velocity.bounce(clamp_to_1bit(collision.get_normal()))
		
	move_and_slide()

func clamp_to_1bit(normal: Vector2):
	var normals = [Vector2(1, 0), Vector2(0, 1), Vector2(-1, 0), Vector2(0, -1)]
	var closest_normal = normals[0]
	var max_dot_product = normal.dot(closest_normal)

	for i in range(1, normals.size()):
		var dot_product = normal.dot(normals[i])
		if dot_product > max_dot_product:
			max_dot_product = dot_product
			closest_normal = normals[i]

	return closest_normal

func hit(body):
	if body.is_in_group("destructible"):
		if body.has_method("destroy"):
			body.destroy()
		else:
			body.queue_free()
