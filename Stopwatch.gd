extends Label
class_name Stopwatch

var time_elapsed: float = 0.0

func _process(delta: float) -> void:
	if not get_tree().paused:
		time_elapsed += delta
		text = seconds2hhmmss(time_elapsed)

func seconds2hhmmss(total_seconds: float) -> String:
	#total_seconds = 12345
	var seconds: float = fmod(total_seconds , 60.0)
	var minutes: int   =  int(total_seconds / 60.0) % 60
	var hhmmss_string: String = "%02d:%05.2f" % [minutes, seconds]
	return hhmmss_string
