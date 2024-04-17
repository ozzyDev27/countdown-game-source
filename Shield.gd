extends StaticBody2D

@export var health = 10
var max_health = 10.0

func destroy():
	health -= 1
	
	if health <= 0:
		if not is_queued_for_deletion():
			$"../../Player".aquire_exagon()
			$"..".queue_free()
	
	modulate = Color(Color.CYAN, 0.7 - lerp(0.7, 0.1, health / max_health))

