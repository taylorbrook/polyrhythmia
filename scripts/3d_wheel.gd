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
	var mat:StandardMaterial3D = $Wheel/Polymark/MeshInstance3D.get_surface_override_material(0)
	mat.albedo_color= Color(randf_range(0.3,0.8),randf_range(0.3,0.8),randf_range(0.3,0.8),1.0)
	var nc = mat.albedo_color
	#nc.a=0.5
	$Wheel.get_surface_override_material(0).albedo_color=nc
	if FileAccess.file_exists("res://mesh/"+str(beats)+"beats.tres"):
		$Wheel/Polymark/MeshInstance3D.mesh=load("res://mesh/"+str(beats)+"beats.tres")
	$Wheel/Polymark/MeshInstance3D.transparency=0.7
	while nbeats < beats:
		var new_mark = $Wheel/Polymark.duplicate()
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
func _physics_process(delta):
	#time+=delta
	if is_instance_valid(song_player) and animation == null:
		if !song_player.is_playing():
			return
		animation = song_player.get_animation("Song1")
		populate_wheel()
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
			populate_wheel()
			last_beat=beat
			
func populate_wheel():
	if animation != null:
			var x = beats
			var ft = read_track(x)
			x=last_beat+x
			if x > beats-1:
				x-=beats
			if ft > -1:
				$Wheel.get_child(x).get_node("MeshInstance3D").transparency=0.0
			else:
				$Wheel.get_child(x).get_node("MeshInstance3D").transparency=0.7

func read_track(offset_beat):
	if animation != null:
		var beat_time=0.0
		#figure out how much time each beat will elapse
		if beats == 3:
			#three wont work unless we snap to 0.333?
			beat_time = snapped(1.0 / float(bps),0.333)
		else:
			beat_time = 1.0 / float(bps)
		#figure out what position to read the track from.
		var beat_future = offset_beat*beat_time
		var current_time = clamp(snapped(song_player.current_animation_position-beat_time,beat_time),0.0,song_player.current_animation_position)
		var pos = snapped(current_time+beat_future,beat_time)
		#find the key near our position
		var nearest_key = animation.track_find_key(track,pos,Animation.FIND_MODE_APPROX)
		if nearest_key > -1:
			print(self.name + " x " + str(offset_beat) + " :: " + str(pos)+ " -- "+str(nearest_key))
		return nearest_key

func _bpm_setter(val):
	bpm=val
	bps = (bpm/60.0)*beats
	beat_steps = (360.0/beats * bps)
