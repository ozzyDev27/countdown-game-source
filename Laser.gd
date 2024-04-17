extends Line2D

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color(Color.WHITE, 0.2)
	pass # Replace with function body.

func fire():
	$VisibleTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(points)
	points[1] = to_local($RayCast2D.get_collision_point())
