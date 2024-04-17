extends RigidBody2D

var speed = 1000  # move speed in pixels/sec
var rotation_speed = 3  # turning speed in radians/sec
var quare = preload("res://quare.tscn")
var exagon = preload("res://exagon.tscn")
@onready var notifier = $"../Notification"
var num_quares = 0
var max_quares = 3
var exagons = 1

func _ready():
	update_display()

func _physics_process(delta):
	look_at(get_global_mouse_position())
	var move_input = Input.get_axis("down", "up")
	var side_input = Input.get_axis("right", "left")
	apply_central_force(transform.y * side_input * speed / 2 + transform.x * move_input * speed)
	
func _input(event):
	if event.is_action_pressed("jump"):
		global_position = get_global_mouse_position()
	if event.is_action_pressed("quare"):
		if num_quares >= max_quares:
			notifier.notify("All Quares in Use!")
			return
		
		if not $"../CollisionCheck".is_clear(get_global_mouse_position()):
			$"../CollisionCheck".flash()
			notifier.notify("Too Close!")
			return
		num_quares += 1
		var new_quare = quare.instantiate()
		new_quare.position = get_global_mouse_position()
		$/root/Node2D.add_child(new_quare)
		new_quare.name = "Quare"
		update_display()
	if event.is_action_pressed("exagon"):
		if exagons <= 0:
			notifier.notify("No Exagons!")
			return
		
		if not $"../CollisionCheck".is_clear(get_global_mouse_position()):
			$"../CollisionCheck".flash()
			notifier.notify("Too Close!")
			return
		exagons -= 1
		var new_exagon = exagon.instantiate()
		new_exagon.position = get_global_mouse_position()
		$/root/Node2D.add_child(new_exagon)
		new_exagon.name = "Exagon"
		update_display()
		#$Gun.shoot()
		
func aquire_quare():
	await get_tree().create_timer(3).timeout
	num_quares -= 1
	update_display()
	
func aquire_exagon():
	await get_tree().create_timer(15).timeout
	exagons += 1
	update_display()

func update_display():
	$"../UI/Quare Count".text = "%d Quares\n%d Exagons" % [(max_quares - num_quares), exagons]

func destroy():
	get_tree().paused = true
	$"../GameOver".visible = true
