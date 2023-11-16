extends Node

var audioSampleBuffer
var samples
var amplitudeR
var amplitudeL

#grabs the buffer from the capture audioeffect
func _ready():
	audioSampleBuffer = AudioServer.get_bus_effect(0,2)


func _process(delta):
	#grabs the past 256 sample values
	samples = audioSampleBuffer.get_buffer(256)
	#grabs the amplitude of the main bus left and right
	amplitudeR = AudioServer.get_bus_peak_volume_right_db(0,0)
	amplitudeL = AudioServer.get_bus_peak_volume_left_db(0,0)
	
#now I need to write the sample values to an image so that is can display like an oscilloscope.
