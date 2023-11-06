extends Node3D
enum directions {Clockwise,CounterClockwise}
@export var beats = 4
@export var bpm = 30 : set = _bpm_setter
@export var spinning = false
@export var direction:directions = directions.Clockwise
@onready var time = 0.0
@onready var bps = (bpm/60.0)*beats #? not sure about this.
@onready var beat_steps = (360.0/beats * bps)
@onready var circle = null

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
	#$Wheel/Polymark/MeshInstance3D.transparency=0.3
	while nbeats < beats:
		var new_mark = $Wheel/Polymark.duplicate()
		$Wheel.add_child(new_mark)
		new_mark.rotation_degrees.y += (360.0/beats) * nbeats
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
var animation:Animation
func _physics_process(delta):
	time+=delta
	if spinning:
		if direction==directions.Clockwise:
			$Wheel.rotation_degrees.x-=beat_steps * delta
		else:
			$Wheel.rotation_degrees.x+=beat_steps * delta
		var beat = int(time*bps) % beats
		if last_beat!=beat:
			if beat == 0:
				measure+=1
				populate_wheel()
			last_beat=beat
			var current_marker = $Wheel.get_child(beat)
			if current_marker.get_node("MeshInstance3D").transparency == 0.0:
				$AnimationPlayer.play("flash_trigger",0.0)
			if is_instance_valid(tlabel):
				tlabel.text=str(beat+1)
				#audio_streams[beat].play()

func populate_wheel():
	if animation != null:
		for x in range(0,beats):
			var ft = read_track(x,1)
			#print(ft)
			if ft > -1:
				$Wheel.get_child(x).get_node("MeshInstance3D").transparency=0.0
			else:
				$Wheel.get_child(x).get_node("MeshInstance3D").transparency=0.7

func read_track(offset_beat,track):
	if animation != null:
		var btime = time + (offset_beat*(bps))
		var pos = snapped(btime - (int(btime / animation.length) * animation.length),(bpm/60.0))
		var nearest_key = animation.track_find_key(track,pos,Animation.FIND_MODE_EXACT)
		#print(pos)
		return nearest_key

func _bpm_setter(val):
	bpm=val
	bps = (bpm/60.0)*beats
	beat_steps = (360.0/beats * bps)
