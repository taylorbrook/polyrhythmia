extends Node3D

@export var SongName: String = "beginner_prelude"
@export var Fog = 0.0 : set = fog_setter

func _ready():
	$BigWheels/MainCam/Camera3D/AnimationPlayer.play("entry")
	await get_tree().create_timer(4.0).timeout
	$SongPlayer.play(SongName)

func fog_setter(val):
	if is_instance_valid($WorldEnvironment):
		var env:Environment = $WorldEnvironment.environment
		env.volumetric_fog_density=val
