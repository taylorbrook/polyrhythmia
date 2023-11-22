extends Node3D
enum directions {Clockwise,CounterClockwise}
@export var beats = 4
@export var bpm = Globals.bpm : set = _bpm_setter
@export var spinning = false
@export var direction:directions = directions.Clockwise
@export var track = 0
@export var tracking = false
@onready var time = 0.0
@onready var bps = (bpm/60.0)*beats
@onready var beat_length = (60.0/bpm) / beats
@onready var beat_steps = (360.0/beats * bps)
@onready var song_player:AnimationPlayer = get_tree().current_scene.get_node("SongPlayer")
@onready var animation:Animation

var last_played_degrees = 0  # variable to keep track of the last played beat
var beat = 0
var ready_notes = []
var ready_color = Color(0.169, 0.388, 0.314)
#@onready var audio_streams = $samples.get_children()  # Array containing all AudioStreamPlayer nodes
@onready var tlabel = find_child("Label3D")
@onready var wheel = $Wheel
# Called when the node enters the scene tree for the first time.
func _ready():
	var nbeats = 1
	#var mat:StandardMaterial3D = $Wheel/Polymark0/MeshInstance3D.get_surface_override_material(0)
	#mat.albedo_color= Color(randf_range(0.3,0.8),randf_range(0.3,0.8),randf_range(0.3,0.8),1.0)
	#var nc = mat.albedo_color
	#nc.a=0.5
	wheel.get_surface_override_material(0).albedo_color=Color(randf_range(0.3,0.8),randf_range(0.3,0.8),randf_range(0.3,0.8),1.0)
	if FileAccess.file_exists("res://mesh/"+str(beats)+"beats.tres"):
		$Wheel/Polymark0/MeshInstance3D.mesh=load("res://mesh/"+str(beats)+"beats.tres")
	$Wheel/Polymark0/MeshInstance3D.transparency=1.0
	#add beats to the wheel
	while nbeats < beats:
		var new_mark = $Wheel/Polymark0.duplicate()
		new_mark.name="Polymark"+str(nbeats)
		var nmesh = new_mark.get_node("MeshInstance3D")
		#nmesh.set_surface_override_material(0,nmesh.get_surface_override_material(0).duplicate())
		wheel.add_child(new_mark)
		#change the direction depending on which way this wheel spins
		if direction == directions.CounterClockwise:
			new_mark.rotation_degrees.y -= (360.0/beats) * nbeats
		else:
			new_mark.rotation_degrees.y += (360.0/beats) * nbeats
		#Debug markers show the beat numbers on them .. hidden by default in the wheel scene.
		new_mark.get_node("MeshInstance3D/DebugMarker").text=str(nbeats+1)
		nbeats+=1
	tlabel.text=str(beats)
	if direction == directions.CounterClockwise:
		$TriggerArea.position.x=-0.4
		wheel.rotation_degrees = Vector3(90.0,-90.0,-90.0)
	else:
		$TriggerArea.position.x=0.4
		wheel.rotation_degrees = Vector3(-90.0,-90.0,-90.0)

var last_beat=-1
var measure = 0
func _process(delta):
	if is_instance_valid(song_player) and animation == null:
		if !song_player.is_playing():
			return
		animation = song_player.get_animation(get_tree().current_scene.SongName)
		if track > animation.get_track_count()-1:
			spinning=false
			return
	if spinning:
		if direction==directions.Clockwise:
			wheel.rotation_degrees.x-=beat_steps * delta
		else:
			wheel.rotation_degrees.x+=beat_steps * delta
		#beat = int((song_player.current_animation_position/60.0)/bpm) % beats
		beat = int(snapped(song_player.current_animation_position,(bpm/60.0)/beats)*bps) % beats
		if Input.is_action_just_pressed("button1") and tracking and $"../..".name=="Left":
			print("LEFT: "+str(wheel.rotation_degrees.x))
		if Input.is_action_just_pressed("button2") and tracking and $"../..".name=="Right":
			print("RIGHT: "+str(wheel.rotation_degrees.x))
		if last_beat!=beat:
			#flash the marker when an active polymarker goes by.
			var current_marker = wheel.get_child(beat).get_node("MeshInstance3D")
			if current_marker.transparency == 0.0:
				$AnimationPlayer.play("flash_trigger",0.0)
				current_marker.transparency=1.0
				current_marker.get_surface_override_material(0).next_pass=null
			if beat == 0:
				measure+=1
			last_beat=beat
	
		#look in the future 1.5 seconds and activate upcoming beats.
		if tracking:
			var cpos = song_player.current_animation_position+1.8
			if cpos > song_player.current_animation_length:
				cpos = abs(cpos - song_player.current_animation_length)
			var fkey = animation.track_find_key(track,cpos,Animation.FIND_MODE_NEAREST)
			if fkey > -1:
				var atime = animation.track_get_key_time(track,fkey)
				var gtime = abs(atime-cpos)
				if gtime <= ((bpm/60.0)/beats):
					var fbeat = int(snapped(cpos,(bpm/60.0)/beats)*bps) % beats
					#var fbeat = int((song_player.current_animation_position/60.0)/bpm) % beats
					var marker = wheel.get_node("Polymark"+str(fbeat)+"/MeshInstance3D")
					if marker.transparency != 0.0:
						marker.get_surface_override_material(0).next_pass = load("res://mesh/outline.tres")
						marker.transparency=0.0

func _bpm_setter(val):
	bpm=val
	bps = (Globals.bpm/60.0)*beats
	beat_steps = (360.0/beats * bps)

func _on_trigger_shape_area_exited(area):
	if area.get_node("..").transparency == 0.0:
		$AnimationPlayer.play("flash_trigger",0.0)
		var current_marker = area.get_parent()
		if current_marker.transparency == 0.0:
			current_marker.transparency=1.0
			current_marker.get_surface_override_material(0).next_pass=null
