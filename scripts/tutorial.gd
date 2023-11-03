extends Node2D
@export var bpm: float = 60
@export var subdiv_r: int = 4
@export var subdiv_l: int = 4

var beatsignal_r: int
var beatsignal_l: int
var measuresignal: float
var measurecount: int

var beat1trigger_r = false
var beat2trigger_r = false
var beat3trigger_r = false
var beat4trigger_r = false

#button inputs "D" and "J"
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("button1"):
		$button1.play()
	if Input.is_action_just_pressed("button2"):
		$button2.play()

	var mstime: float = Time.get_ticks_msec()
	var beatsignal_r_float: float = (mstime / 1000) / (bpm / 60)
	var beatsignal_r = int(beatsignal_r_float) % subdiv_r + 1
	
	# calculate measures
	var measuresignal: float = (mstime / 1000) / (bpm / 60) / 4
	var measurecount = int(measuresignal)

	#debug
	print(beat3trigger_r)
