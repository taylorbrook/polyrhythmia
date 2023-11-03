extends Control

@export var beats = 4
@onready var time = 0.0
@export var bpm = 60
@onready var bps = bpm/60.0
@onready var beat_steps = (360.0/beats * bps)
@onready var circle = $RhythmCircle
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
		
func _on_h_slider_value_changed(value):
	$HSlider/Label.text=str(value)+" BPM"
	bpm = $HSlider.value
	bps = bpm/60.0
	beat_steps = (360.0/beats * bps)
