extends Line2D

func _ready():
	$RayCast2D.target_position = $"..".linear_velocity * 5000
	$RayCast2D.force_raycast_update()

func _physics_process(delta):
	#global_rotation = $"..".linear_velocity.angle()
	$RayCast2D.target_position = $"..".linear_velocity * 5000
	points[1] = $"..".linear_velocity * 5000
	if $RayCast2D.get_collider() != null and $RayCast2D.get_collider().name == "Player":
		visible = true
	else:
		visible = false
