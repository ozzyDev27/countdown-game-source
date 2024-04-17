extends StaticBody2D

@onready var player = $"../Player"
var aiming = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if aiming:
		look_at(player.global_position)

func fire_laser():
	var tween = get_tree().create_tween()
	
	aiming = false
	tween.set_parallel(true)
	tween.tween_property($Sprite2D/TextureRect, "position", Vector2(-2000, -370), 1).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($Line2D, "modulate", Color.WHITE, 1).set_ease(Tween.EASE_IN)
	tween.set_parallel(false)
	tween.tween_callback($Line2D.fire)
	tween.tween_interval(0.2)
	tween.tween_callback(check_player)
	tween.set_parallel(true)
	tween.tween_property($Line2D, "modulate", Color(Color.WHITE, 0.2), 0.2).set_ease(Tween.EASE_OUT)
	tween.tween_property($Sprite2D/TextureRect, "position", Vector2(-1700, -370), 0.5).set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel(false)
	tween.tween_callback(start_aim)
	
func start_aim():
	aiming = true
	
func check_player():
	var body = $Line2D/RayCast2D.get_collider()
	if body != null and body.is_in_group("destructible"):
		if body.has_method("destroy"):
			body.destroy()
		else:
			body.queue_free()


func hit(body: Node2D):
	if body.name == "Clock":
		queue_free()
	elif body.name == "Bullet":
		body.queue_free()
		queue_free()
