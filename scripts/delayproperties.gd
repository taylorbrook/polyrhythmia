extends Node

@export var delaytap1 = 0.0 : set = _delay_setter, get = _delay_getter 

func _ready():
	_delay_getter()

func _delay_setter(val):
	#when your variable is 'set', this code is executed.
	delaytap1 = val
	AudioServer.get_bus_effect(1,0).tap1_delay_ms = val
	
func _delay_getter():
	#when your variable is retrieved, this code is executed.
	return AudioServer.get_bus_effect(1,0).tap1_delay_ms

func _process(delta):
	print(delaytap1)
