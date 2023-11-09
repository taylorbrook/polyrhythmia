extends Node3D
enum directions {Clockwise,CounterClockwise}
@export var beats = 4
@export var bpm = 30 : set = _bpm_setter
@export var spinning = false
@export var direction:directions = directions.Clockwise
@export var track = 0
@onready var time = 0.0
@onready var bps = (bpm/60.0)*beats
@onready var beat_steps = (360.0/beats * bps)
@onready var song_player:AnimationPlayer
@onready var animation:Animation
var last_played_degrees = 0  # variable to keep track of the last played beat

var ready_notes = []
var ready_color = Color(0.169, 0.388, 0.314)
#@onready var audio_streams = $samples.get_children()  # Array containing all AudioStreamPlayer nodes
@onready var tlabel = find_child("Label3D")
# Called when the node enters the scene tree for the first time.
func _ready():
	var nbeats = 1
	var mat:StandardMaterial3D = $Wheel/Polymark0/MeshInstance3D.get_surface_override_material(0)
	mat.albedo_color= Color(randf_range(0.3,0.8),randf_range(0.3,0.8),randf_range(0.3,0.8),1.0)
	var nc = mat.albedo_color
	#nc.a=0.5
	$Wheel.get_surface_override_material(0).albedo_color=nc
	if FileAccess.file_exists("res://mesh/"+str(beats)+"beats.tres"):
		$Wheel/Polymark0/MeshInstance3D.mesh=load("res://mesh/"+str(beats)+"beats.tres")
	$Wheel/Polymark0/MeshInstance3D.transparency=0.7
	while nbeats < beats:
		var new_mark = $Wheel/Polymark0.duplicate()
		new_mark.name="Polymark"+str(nbeats)
		$Wheel.add_child(new_mark)
		if direction == directions.CounterClockwise:
			new_mark.rotation_degrees.y -= (360.0/beats) * nbeats
		else:
			new_mark.rotation_degrees.y += (360.0/beats) * nbeats
		new_mark.get_node("MeshInstance3D/DebugMarker").text=str(nbeats+1)
		#new_mark.rotation_degrees.y += (360.0/beats) * nbeats
		nbeats+=1
	tlabel.text=str(beats)
	if direction == directions.CounterClockwise:
		$TriggerArea.position.x=-0.4
		$Wheel.rotation_degrees = Vector3(90.0,-90.0,-90.0)
	else:
		$TriggerArea.position.x=0.4
		$Wheel.rotation_degrees = Vector3(-90.0,-90.0,-90.0)
	#$AnimationPlayer.speed_scale=0.125*beats
	
	pass # Replace with function body.

var last_beat=-1
var measure = 0
func _process(delta):
	#time+=delta
	if is_instance_valid(song_player) and animation == null:
		if !song_player.is_playing():
			return
		animation = song_player.get_animation("Song1")
	if spinning:
		if direction==directions.Clockwise:
			$Wheel.rotation_degrees.x-=beat_steps * delta
		else:
			$Wheel.rotation_degrees.x+=beat_steps * delta
		var beat = int(song_player.current_animation_position*bps) % beats
		if last_beat!=beat:
			var current_marker = $Wheel.get_child(beat).get_node("MeshInstance3D")
			if current_marker.transparency == 0.0:
				$AnimationPlayer.play("flash_trigger",0.0)
				current_marker.transparency=0.7
			if is_instance_valid(tlabel):
				tlabel.text=str(beat+1)
				#audio_streams[beat].play()
			if beat == 0:
				measure+=1
			last_beat=beat
		var cpos = song_player.current_animation_position+1.5
		if cpos > song_player.current_animation_length:
			cpos = abs(cpos - song_player.current_animation_length)
		var fkey = animation.track_find_key(track,cpos,Animation.FIND_MODE_NEAREST)
		if fkey > -1:
			var gtime = abs(animation.track_get_key_time(track,fkey)-cpos)
			if gtime <= ((bpm/60.0)/beats):
				var fbeat = int(cpos*bps) % beats
				var marker = $Wheel.get_node("Polymark"+str(fbeat)+"/MeshInstance3D")
				if marker.transparency != 0.0:
					marker.transparency=0.0


func _bpm_setter(val):
	bpm=val
	bps = (bpm/60.0)*beats
	beat_steps = (360.0/beats * bps)
