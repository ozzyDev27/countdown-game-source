extends Line2D

@export var point_a: Node2D
@export var point_b: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	top_level = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	points[0] = point_a.global_position
	points[1] = point_b.global_position
