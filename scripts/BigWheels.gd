extends Node3D

var times = []
var small_wheels = []
var tracks = []
@onready var song_player:AnimationPlayer = get_tree().current_scene.get_node("SongPlayer")

var rcount = 0
func _process(delta):
	if !song_player.is_playing():
		return
	var time_gap = 10.0
	if times.size() > 0:
		time_gap = abs(song_player.current_animation_position - times.front())
	if time_gap <= 1.0:
		small_wheels.front().tracking=true
	if time_gap <= 0.1:
		#print(abs(song_player.current_animation_position - times.front()))
		times.pop_front()
		var small_wheel = small_wheels.pop_front()
		rcount+=1
		if rcount > 2:
			small_wheel.get_parent().get_parent().get_child(0).queue_free()
			var stepper = spoke_step
			if small_wheel.direction == small_wheel.directions.CounterClockwise:
				stepper= -spoke_step
			var tween = get_tree().create_tween()
			var big_wheel = small_wheel.get_parent().get_parent()
			tween.tween_property(big_wheel,"rotation_degrees:z",big_wheel.rotation_degrees.z-stepper,0.25)
var spoke_step = 0.0
func _ready():
	#read the entire animation and create an array of subdivisions in the order they appear.
	#create all the neccessary wheels. (duplicates of the existing wheels, minus the sound players?)
	#align them in a wheel shape alternating the sides they appear on.
	read_animation(song_player.get_animation(get_tree().current_scene.SongName))
	var wheels = [$Left,$Right]
	var side = false
	spoke_step = 360.0 / round(all_subdivisions.size())
	var on_rot_l = 0.0
	var on_rot_r= 0.0
	for d in all_subdivisions:
		var tnode = get_tree().current_scene.get_node(d)
		var new_wheel = load("res://rhythms/3d_wheel.tscn").instantiate()
		new_wheel.beats=int(tnode.name.split("NotePlayer")[1].split("_")[0])
		new_wheel.bpm=Globals.bpm
		new_wheel.track=tracks.pop_front()
		var new_pivot = Node3D.new()
		if side:
			new_wheel.direction = new_wheel.directions.CounterClockwise
		new_pivot.add_child(new_wheel)
		wheels[int(side)].add_child(new_pivot)
		if side:
			new_wheel.direction = new_wheel.directions.CounterClockwise
			new_wheel.position=Vector3(-4.0,0.0,0.0)
			side=false
			new_pivot.rotation_degrees = Vector3(0.0,0.0,-on_rot_r)
			on_rot_r+=spoke_step
		else:
			side=true
			new_wheel.position=Vector3(4.0,0.0,0.0)
			new_pivot.rotation_degrees = Vector3(0.0,0.0,on_rot_l)
			on_rot_l+=spoke_step
		new_wheel.rotation_degrees = Vector3.ZERO
		new_wheel.show()
		new_wheel.spinning=true
		small_wheels.append(new_wheel)

var all_subdivisions = []

func read_animation(anim:Animation):
	var track_count = anim.get_track_count()
	var t = 0
	for y in range(0,anim.length / 0.01):
		for x in range(0,track_count):
			var tpath:String = anim.track_get_path(x)
			if tpath.find("NotePlayer") == -1:
				continue
			t+=1
			var key = anim.track_find_key(x,y,Animation.FIND_MODE_APPROX)
			if key > -1:
				var asize = all_subdivisions.size()
				if (asize > 0 and all_subdivisions[asize-1] != tpath) or (asize == 0):
					all_subdivisions.append(tpath)
					times.append(y)
					tracks.append(x)
	print("checked "+str(t))
	print(all_subdivisions)
func next_subwheel():
	#cycle to the next big wheel position, alternating left and right.
	pass
