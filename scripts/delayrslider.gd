extends HSlider

@export 
var bus_name: String
var effect_name: String

var bus_index: int
var effect_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	
