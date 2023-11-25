extends Node3D

@export var SongName: String = Globals.levelName
@export var Fog = 0.0 : set = fog_setter
var animation_speed: float

var bpm_multiplier = Globals.bpm/30.

func _ready():
	$BigWheels/MainCam/Camera3D/AnimationPlayer.play("entry")
	await get_tree().create_timer(4.0).timeout
	$SongPlayer.play(SongName, 0, bpm_multiplier)
	_update_score(0)
	var tween = create_tween().set_loops()
	tween.tween_property($BigWheels/OmniLight3D, "light_energy", 1.3, bpm_multiplier).from_current().set_ease(Tween.EASE_OUT)

func fog_setter(val):
	if is_instance_valid($Backdrop/WorldEnvironment):
		var env:Environment = $Backdrop/WorldEnvironment.environment
		env.volumetric_fog_density=val

func _on_song_player_animation_finished(anim_name):
	get_tree().change_scene_to_file("res://levels/menu.tscn")
	Sound.transition_start()

func _update_score(val):
	var tween = create_tween().set_loops()
	tween.tween_property($ui/score, "scale", Vector2(1.1,1.1), bpm_multiplier).from_current().set_ease(Tween.EASE_OUT)
	$ui/score.text = str(val)
	
