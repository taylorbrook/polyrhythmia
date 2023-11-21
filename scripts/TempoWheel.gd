extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.bpm = 30
	$tempoDisplay.text = str(Globals.bpm * 2)


func clicked():
	print("clicked")
