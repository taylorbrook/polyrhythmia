extends Node

var delaytap1 = AudioServer.get_bus_effect(1,0).tap1_delay_ms

func _process(delta):
	print(delaytap1)
