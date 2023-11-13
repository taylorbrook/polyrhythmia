extends Node3D

var wheel_sets = []

var spoke_step = 0.0
@onready var song_player:AnimationPlayer = get_tree().current_scene.get_node("SongPlayer")

var rcount = 0
func _process(delta):
	if !song_player.is_playing():
		return
	var time_gap = 10.0
	if wheel_sets.size() > 0:
		time_gap = abs(song_player.current_animation_position - wheel_sets.front().time)
	if time_gap <= 2.0 and !wheel_sets.front().node.tracking:
		wheel_sets.front().node.tracking=true
	if time_gap <= 0.1 and wheel_sets.front().node.beat == 0:
		var current_wheel = wheel_sets.pop_front()
		var small_wheel = current_wheel.node
		rcount+=1
		if rcount > 2:
			small_wheel.get_parent().get_parent().get_child(0).queue_free()
			var stepper = spoke_step
			if small_wheel.direction == small_wheel.directions.CounterClockwise:
				stepper= -spoke_step
			var tween = get_tree().create_tween()
			var big_wheel = small_wheel.get_parent().get_parent()
			tween.tween_property(big_wheel,"rotation_degrees:z",big_wheel.rotation_degrees.z-stepper,0.25)

func _ready():
	read_animation(song_player.get_animation(get_tree().current_scene.SongName))
	var wheels = [$Left,$Right]
	var side = false
	spoke_step = 360.0 / round(wheel_sets.size())
	var on_rot_l = 0.0
	var on_rot_r= 0.0
	var wi = 0
	for d in wheel_sets:
		var tnode = get_tree().current_scene.get_node(d.path)
		var beats = int(tnode.name.split("NotePlayer")[1].split("_")[0])
		if tnode.name.split("_")[1] == "R":
			side=true
		else:
			side=false
		var new_wheel = load("res://rhythms/3d_wheel.tscn").instantiate()
		new_wheel.beats=beats
		new_wheel.bpm=Globals.bpm
		new_wheel.track=d.track
		var new_pivot = Node3D.new()
		if side:
			new_wheel.direction = new_wheel.directions.CounterClockwise
		new_pivot.add_child(new_wheel)
		wheels[int(side)].add_child(new_pivot)
		if side:
			new_wheel.direction = new_wheel.directions.CounterClockwise
			new_wheel.position=Vector3(-4.0,0.0,0.0)
			#side=false
			new_pivot.rotation_degrees = Vector3(0.0,0.0,-on_rot_r)
			on_rot_r+=spoke_step
		else:
			#side=true
			new_wheel.position=Vector3(4.0,0.0,0.0)
			new_pivot.rotation_degrees = Vector3(0.0,0.0,on_rot_l)
			on_rot_l+=spoke_step
		new_wheel.rotation_degrees = Vector3.ZERO
		new_wheel.show()
		new_wheel.spinning=true
		wheel_sets[wi].node=new_wheel
		wheel_sets[wi].beats=beats
		wi+=1

func read_animation(anim:Animation):
	var track_count = anim.get_track_count()
	var t = 0
	var cleft=null
	var cright=null
	for y in range(0,anim.length / 0.01):
		for x in range(0,track_count):
			var tpath:String = anim.track_get_path(x)
			if tpath.find("NotePlayer") == -1:
				t+=1
				continue
			t+=1
			var key = anim.track_find_key(x,y,Animation.FIND_MODE_APPROX)
			var side = false
			if key > -1:
				if tpath.split("_")[1] == "R":
					side=true
				var asize = wheel_sets.size()
				if (side and cright != tpath) or (!side and cleft != tpath):
					wheel_sets.append({time=y,track=x,path=tpath,node=null,beats=0})
					if side:
						cright=tpath
					else:
						cleft=tpath
	print("checked "+str(t))
func next_subwheel():
	#cycle to the next big wheel position, alternating left and right.
	pass
