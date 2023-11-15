extends HSlider

func _ready():
	$bpmValue.text = str(Globals.bpm)

func _value_changed(new_value):
	Globals.bpm = value
	$bpmValue.text = str(Globals.bpm)
