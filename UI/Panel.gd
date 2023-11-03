extends Panel

var time : float = 60
var minutes : int = 0
var seconds : int = 0
var msec : int = 0

func _process(_delta):
	time = $Timer.time_left
	msec = fmod(time, 1) * 100
	seconds = fmod(time, 60)
	minutes = fmod(time, 3600) / 60
	$seconds.text = "%02d:" % seconds
	$miliseconds.text = "%02d" % msec
