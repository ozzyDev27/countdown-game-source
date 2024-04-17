extends CollisionShape2D

@onready var font: Font = $"../Label".get_theme_font("font")

# Called when the node enters the scene tree for the first time.
func _ready():
	update_size()

func update_size():
	var bbox = font.get_string_size($"../Label".text, HORIZONTAL_ALIGNMENT_LEFT, -1, $"../Label".get_theme_font_size("font_size"))
	#print(bbox)
	bbox.y /= 2.2
	bbox.x -= 20
	get_shape().extents = bbox / 2
	#print(bbox)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_size()
