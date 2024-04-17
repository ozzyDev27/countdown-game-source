extends CollisionShape2D

enum AXIS {X, Y}

@export var match_axis = AXIS.X

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var size = get_viewport().size
	if match_axis == AXIS.X:
		self.position.x = size.x
	elif match_axis == AXIS.Y:
		self.position.y = size.y
