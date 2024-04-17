extends RigidBody2D

@onready var player = $"../Player"

func hit(body):
	if body.is_in_group("destructible"):
		if body.has_method("destroy"):
			body.destroy()
		else:
			body.queue_free()
		queue_free()
	if body.name == "Border":
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	apply_central_force((global_position - player.global_position).normalized() * -300)
