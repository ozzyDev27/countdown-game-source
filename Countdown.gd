extends Label
var target_time = null

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	print(json)
	if json and "timestamp" in json:
		target_time = json["timestamp"]

# Called when the node enters the scene tree for the first time.
func _ready():
	update_time()

func update_time():
	target_time = null
	$HTTPRequest.request_completed.connect(_on_request_completed)
	$HTTPRequest.request("https://flask-hello-world-nine-psi.vercel.app")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target_time:
		var time_remaining = target_time - Time.get_unix_time_from_system() + 3600 * 4 # correct for EDT timezone
		if time_remaining < 0:
			update_time()
		var remaining_minutes = floor(time_remaining / 60)
		var remaining_seconds = int(time_remaining) % 60
		text = "%d:%02d" % [remaining_minutes, remaining_seconds]
	else:
		text = "Loading"
