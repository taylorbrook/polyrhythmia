extends Node2D
@export var bpm: float = 60
@export var subdiv_r: int = 4
@export var subdiv_l: int = 4

var beat1trigger = false
var beatsignal: int
var measuresignal: float
var measurecount: int

#button inputs "D" and "J"
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("button1"):
		$button1.play()
	if Input.is_action_just_pressed("button2"):
		$button2.play()

	var mstime: float = Time.get_ticks_msec()
	var beatsignalf: float = (mstime / 1000) / (bpm / 60)
	var beatsignal = int(beatsignalf) % subdiv_r + 1
	
	# calculate measures
	var measuresignal: float = beatsignalf / 4
	var measurecount = int(measuresignal)

	# trigger subdivisions
	if(beatsignal >= 1 and beat1trigger == false):
		beat1trigger = true
		print(beat1trigger)
		
	print(measurecount)
