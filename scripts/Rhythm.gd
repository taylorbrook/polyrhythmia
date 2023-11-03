extends Control

@export var beats = 4
@onready var time = 0.0
@export var bpm = 60
@onready var bps = bpm/60.0
@onready var beat_steps = (360.0/beats * bps)
@onready var circle = $RhythmCircle

var last_played_degrees = 0  # variable to keep track of the last played beat

var audio_streams = [
	$samples/g0,
	$samples/g1,
	$samples/d2,
	$samples/a2
	]  # Array containing all AudioStreamPlayer nodes

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	circle.rotation_degrees+=beat_steps * delta
	for c in circle.get_children():
		c.rotation_degrees=-circle.rotation_degrees
	var note = "Too slow."
	time += delta
	if Input.is_action_just_pressed("button1"):
		var perfect = int(360/beats) #the perfect position of a beat marker
		var timing = perfect - (int(circle.rotation_degrees) % perfect) #the offset of the position
		if timing <= 9:
			note = "Perfect!"
		elif timing < 17:
			note = "Good!"
		$AudioStreamPlayer.play()
		$TimeNote.text=note
	check_beat()
	
func check_beat():
	var current_degrees = int(circle.rotation_degrees)
	if current_degrees != last_played_degrees:  # To play the AudioStream only when a new beat is reached
		last_played_degrees = current_degrees
		for i in range(0, 4):  # Checking for each 90-degree interval
			if current_degrees % 360 == (i * 90):
				print(audio_streams[i])

func _on_h_slider_value_changed(value):
	$HSlider/Label.text=str(value)+" BPM"
	bpm = $HSlider.value
	bps = bpm/60.0
	beat_steps = (360.0/beats * bps)
