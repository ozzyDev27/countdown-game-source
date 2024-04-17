extends Label

@export var stopwatch: Stopwatch

func get_scores():
	$HTTPRequest.request("https://flask-hello-world-nine-psi.vercel.app/leaderboard")
	
func submit_score():
	var encrypted_score = "EGH" + Marshalls.utf8_to_base64(str(stopwatch.time_elapsed))
	print(encrypted_score)
	$HTTPRequest.request_completed.connect(_on_request_completed)
	$HTTPRequest.request("https://flask-hello-world-nine-psi.vercel.app/leaderboard?score=%s" % encrypted_score, [], HTTPClient.METHOD_POST)

func _on_request_completed(result, response_code, headers, body):
	if body.get_string_from_utf8() == "OK":
		get_scores()
		return true
	var json = JSON.parse_string(body.get_string_from_utf8())
	#print(json)
	if json and "scores" in json:
		var scores = json["scores"]
		#print(scores)
		var score = stopwatch.time_elapsed
		var placement = closest(score, scores)
		print(placement)
		print(len(scores))
		
		if placement < 50:
			text = "You placed #%d\n" % [placement]
		else:
			text = "You placed top %d%%\n" % [(float(placement) / len(scores)) * 100]
		var n = 1
		while n <= 5 and n <= len(scores):
			text += "%d. %s\n" % [ n, seconds2mmss(scores[n-1]) ]
			n += 1

func closest(my_number:int, my_array:Array)->int:
	# Initialize
	var closest_num:int
	var closest_delta:int = 0
	var closest_idx = -1
	var temp_delta:int = 0
	# Loop through entire array
	for i in range(my_array.size()):
		if my_array[i] == my_number: return my_array[i] # exact match found!
		temp_delta = int(abs(my_array[i]-my_number))
		if closest_delta == 0 or temp_delta < closest_delta:
			closest_num = my_array[i]
			closest_idx = i
			closest_delta = temp_delta
	# Return closest number found
	return closest_idx

func seconds2mmss(total_seconds: float) -> String:
	var seconds: float = fmod(total_seconds , 60.0)
	var minutes: int   =  int(total_seconds / 60.0) % 60
	var hhmmss_string: String = "%02d:%05.2f" % [minutes, seconds]
	return hhmmss_string
