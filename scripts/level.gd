extends Node3D

@export var SongName: String = Globals.levelName
@export var Fog = 0.0 : set = fog_setter
var animation_speed: float

func _ready():
	$BigWheels/MainCam/Camera3D/AnimationPlayer.play("entry")
	animation_speed = Globals.bpm/30.
	await get_tree().create_timer(4.0).timeout
	$SongPlayer.play(SongName, 0, animation_speed)

func fog_setter(val):
	if is_instance_valid($Backdrop/WorldEnvironment):
		var env:Environment = $Backdrop/WorldEnvironment.environment
		env.volumetric_fog_density=val
