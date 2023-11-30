extends Node3D

@export var SongName: String = Globals.levelName
@export var Fog = 0.0 : set = fog_setter
var animation_speed: float

var bpm_multiplier = Globals.bpm/30.
var score
var scoreFeedback = " "
var combo_counter

func _ready():
	_reset_score()
	$BigWheels/MainCam/Camera3D/AnimationPlayer.play("entry")
	await get_tree().create_timer(4.0).timeout
	$SongPlayer.play(SongName, 0, bpm_multiplier)
	$BigWheels/ReactionNotes/AnimationPlayer.speed_scale=Globals.bpm/30.0
	$BigWheels/ReactionNotes/AnimationPlayer2.speed_scale=Globals.bpm/30.0
	var tween = create_tween().set_loops()
	tween.tween_property($BigWheels/OmniLight3D, "light_energy", 1.3, bpm_multiplier).from_current().set_ease(Tween.EASE_OUT)

func fog_setter(val):
	if is_instance_valid(find_child("Backdrop/WorldEnvironment")):
		var env:Environment = $Backdrop/WorldEnvironment.environment
		env.volumetric_fog_density=val

func _on_song_player_animation_finished(_anim_name):
	get_tree().change_scene_to_file("res://levels/menu.tscn")
	Sound.transition_start()

#score system - takes value and scales with bpm mulitplier and combo counter
func _reset_score():
	score = 0
	$ui/score.text = str(score)
	combo_counter = 0
	scoreFeedback = " "
	
func _update_score(val):
	var tween = create_tween().set_loops()
	tween.tween_property($ui/score, "scale", Vector2(1.1,1.1), bpm_multiplier).from_current().set_ease(Tween.EASE_OUT)
	tween.play()
	score += val*bpm_multiplier*(combo_counter*.5)
	$ui/score.text = str(int(score))
	$ui/scoreFeedback.text = scoreFeedback
	if combo_counter > 0:
		$ui/scoreFeedback.text += "combo x" + str(combo_counter)

func _perfect(lr):
	scoreFeedback = "perfect!"
	var col=Color(0.184, 0.561, 0.263)
	if lr:
		$BigWheels/ReactionNotes/Right.mesh.material.albedo_color=col
		feedback_right(scoreFeedback)
	else:
		$BigWheels/ReactionNotes/Left.mesh.material.albedo_color=col
		feedback_left(scoreFeedback)
	_update_score(10)
	combo_counter += 2
	
func _good(lr):
	scoreFeedback = "good!"
	var col=Color(0.874, 0.879, 0.511)
	if lr:
		$BigWheels/ReactionNotes/Right.mesh.material.albedo_color=col
		feedback_right(scoreFeedback)
	else:
		$BigWheels/ReactionNotes/Left.mesh.material.albedo_color=col
		feedback_left(scoreFeedback)
	_update_score(5)
	combo_counter += 1

func _miss(lr):
	scoreFeedback = "miss!"
	var col=Color(0.785, 0.12, 0.067)
	if lr:
		$BigWheels/ReactionNotes/Right.mesh.material.albedo_color=col
		feedback_right(scoreFeedback)
	else:
		$BigWheels/ReactionNotes/Left.mesh.material.albedo_color=col
		feedback_left(scoreFeedback)
	_update_score(0)
	combo_counter = 0

func feedback_left(text):
	$BigWheels/ReactionNotes/Left.mesh.text=text
	if !$BigWheels/ReactionNotes/AnimationPlayer.is_playing():
		$BigWheels/ReactionNotes/AnimationPlayer.play("show_left")
	else:
		$BigWheels/ReactionNotes/AnimationPlayer.seek(0.0,true)

func feedback_right(text):
	$BigWheels/ReactionNotes/Right.mesh.text=text
	if !$BigWheels/ReactionNotes/AnimationPlayer2.is_playing():
		$BigWheels/ReactionNotes/AnimationPlayer2.play("show_right")
	else:
		$BigWheels/ReactionNotes/AnimationPlayer2.seek(0.0,true)
