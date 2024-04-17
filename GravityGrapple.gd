extends RayCast2D

var active = false
@export var force = -1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if active:
		$Marker2D.node.apply_central_force(($Marker2D.node.global_position - global_position).normalized() * force)
		$"..".apply_central_force((global_position - $Marker2D.node.global_position).normalized() * force)

func _input(event):
	if event.is_action_pressed("shoot"):
		if (not is_colliding()) or (not get_collider() is RigidBody2D):
			return
		$Line2D.visible = true
		active = true
		$Marker2D.node = get_collider()
		$Marker2D.offset = get_collider().global_position - get_collision_point()
	elif event.is_action_released("shoot"):
		$Line2D.visible = false
		active = false
