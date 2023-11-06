extends Control

@export var beats = 4
@onready var time = 0.0
@export var bpm = 30
@onready var bps = (bpm/60.0)*beats
@onready var beat_steps = (360.0/beats * bps)
@onready var circle = $RhythmCircle

var last_played_degrees = 0  # variable to keep track of the last played beat

@onready var audio_streams = $samples.get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("test_animation_taylor")

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
		$playersamples/player_g3.play()
		$TimeNote.text=note
	check_beat()
	
func check_beat():
	var current_degrees = int(circle.rotation_degrees)
	if current_degrees != last_played_degrees:  # To play the AudioStream only when a new beat is reached
		last_played_degrees = current_degrees
		for i in range(0, 12):  # Checking for each 90-degree interval
			if current_degrees % 360 == (i * 30):
				if i < audio_streams.size():
					audio_streams[i].play()

func _on_h_slider_value_changed(value):
	$HSlider/Label.text=str(value)+" BPM"
	bpm = $HSlider.value
	bps = bpm/60.0
	beat_steps = (360.0/beats * bps)
