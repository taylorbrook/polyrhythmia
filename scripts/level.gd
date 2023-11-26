extends Node3D

@export var SongName: String = Globals.levelName
@export var Fog = 0.0 : set = fog_setter
var animation_speed: float

var bpm_multiplier = Globals.bpm/30.
var score
var scoreFeedback = " "
var combo_counter

#func _process(delta):
#	#for testing score system
#	if Input.is_key_pressed(KEY_A):
#		_perfect()
#	if Input.is_key_pressed(KEY_S):
#		_good()
#	if Input.is_key_pressed(KEY_D):
#		_miss()

func _ready():
	_reset_score()
	_update_score(0)
	$BigWheels/MainCam/Camera3D/AnimationPlayer.play("entry")
	await get_tree().create_timer(4.0).timeout
	$SongPlayer.play(SongName, 0, bpm_multiplier)
	var tween = create_tween().set_loops()
	tween.tween_property($BigWheels/OmniLight3D, "light_energy", 1.3, bpm_multiplier).from_current().set_ease(Tween.EASE_OUT)

func fog_setter(val):
	if is_instance_valid($Backdrop/WorldEnvironment):
		var env:Environment = $Backdrop/WorldEnvironment.environment
		env.volumetric_fog_density=val

func _on_song_player_animation_finished(anim_name):
	get_tree().change_scene_to_file("res://levels/menu.tscn")
	Sound.transition_start()

#score system - takes value and scales with bpm mulitplier and combo counter
func _reset_score():
	score = 0
	combo_counter = 0
	scoreFeedback = " "
	
func _update_score(val):
	var tween = create_tween().set_loops()
	tween.tween_property($ui/score, "scale", Vector2(1.1,1.1), bpm_multiplier).from_current().set_ease(Tween.EASE_OUT)
	score += val*bpm_multiplier*(combo_counter*.5)
	$ui/score.text = str(score)
	$ui/scoreFeedback.text = scoreFeedback + "combo x" + str(combo_counter)

func _perfect():
	scoreFeedback = "perfect!"
	_update_score(10)
	combo_counter += 1
	
func _good():
	scoreFeedback = "good!"
	_update_score(5)
	combo_counter += 1

func _miss():
	scoreFeedback = "miss!"
	_update_score(0)
	combo_counter = 0
