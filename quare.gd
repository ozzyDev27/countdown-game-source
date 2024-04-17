extends StaticBody2D


func destroy():
	var timer = Timer.new()
	if not is_queued_for_deletion():
		$"../Player".aquire_quare()
		queue_free()
