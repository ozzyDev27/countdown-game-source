extends Label


func notify(notification_text):
	text = notification_text
	modulate = Color.WHITE
	var tween = get_tree().create_tween()
	
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 1).set_ease(Tween.EASE_OUT)
