extends TextureRect

@export var speed = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var move_amount = delta * speed
	self.size.x += move_amount
	self.position.x -= move_amount
