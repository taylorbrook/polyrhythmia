extends Node

@export var delaytap1 = 0.0 : set = _delaytap1_setter, get = _delaytap1_getter
@export var delaytap2 = 0.0 : set = _delaytap2_setter, get = _delaytap2_getter

#need to scale delay times with bpm

func _ready():
	_delaytap1_getter()
	_delaytap2_getter()

func _delaytap1_setter(val):
	#when your variable is 'set', this code is executed.
	delaytap1 = val
	AudioServer.get_bus_effect(1,0).tap1_delay_ms = val
	
func _delaytap2_setter(val):
	#when your variable is 'set', this code is executed.
	delaytap2 = val
	AudioServer.get_bus_effect(1,0).tap2_delay_ms = val
	
func _delaytap1_getter():
	#when your variable is retrieved, this code is executed.
	return AudioServer.get_bus_effect(1,0).tap1_delay_ms
	
func _delaytap2_getter():
	#when your variable is retrieved, this code is executed.
	return AudioServer.get_bus_effect(1,0).tap2_delay_ms

func _process(delta):
	print(delaytap1)
	print(delaytap2)
