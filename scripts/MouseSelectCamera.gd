extends Camera3D

var m_pos = Vector2()

func _input(event):
	if event is InputEventMouse:
		m_pos = event.position
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			raycast_from_mouse(m_pos, 1)

func raycast_from_mouse(m_pos, collision_mask):
	var ray_start = project_ray_origin(m_pos)
	var ray_end = ray_start + project_ray_normal(m_pos) * 100
	var world3d : World3D = get_world_3d()
	var space_state = world3d.direct_space_state

	if space_state == null:
		return

	var query = PhysicsRayQueryParameters3D.create(ray_start, ray_end, collision_mask)
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)

	if result.is_empty():
		return

	#start game button
	if result.collider == %startGame:
		get_tree().change_scene_to_file("res://levels/3d_test.tscn")
		Sound.transition_start()
		
	#level select wheel buttons
	if result.collider == %TriggerShape1:
		$"../LevelWheel/levelName".text = "tutorial"
		$"../LevelWheel/levelDifficulty".text = "beginner"

	if result.collider == %TriggerShape2:
		$"../LevelWheel/levelName".text = "prelude"
		$"../LevelWheel/levelDifficulty".text = "beginner"

	if result.collider == %TriggerShape3:
		$"../LevelWheel/levelName".text = "vines"
		$"../LevelWheel/levelDifficulty".text = "beginner"

	if result.collider == %TriggerShape4:
		$"../LevelWheel/levelName".text = "spinning"
		$"../LevelWheel/levelDifficulty".text = "intermediate"

	if result.collider == %TriggerShape5:
		$"../LevelWheel/levelName".text = "hocket canon"
		$"../LevelWheel/levelDifficulty".text = "intermediate"

	if result.collider == %TriggerShape6:
		$"../LevelWheel/levelName".text = "whirl"
		$"../LevelWheel/levelDifficulty".text = "advanced"

	if result.collider == %TriggerShape7:
		$"../LevelWheel/levelName".text = "coming soon!"
		$"../LevelWheel/levelDifficulty".text = "advanced"

	if result.collider == %TriggerShape8:
		$"../LevelWheel/levelName".text = "coming soon!"
		$"../LevelWheel/levelDifficulty".text = "advanced"

	#tempo select wheel
	if result.collider == %TempoTrigger1:
		$"../TempoWheel/tempoDisplay".text = "50"
		$"../TempoWheel/difficultylevel".text = "beginner"
		Globals.bpm = 25

	if result.collider == %TempoTrigger2:
		$"../TempoWheel/tempoDisplay".text = "60"
		$"../TempoWheel/difficultylevel".text = "easy"
		Globals.bpm = 30

	if result.collider == %TempoTrigger3:
		$"../TempoWheel/tempoDisplay".text = "70"
		$"../TempoWheel/difficultylevel".text = "easy"
		Globals.bpm = 35

	if result.collider == %TempoTrigger4:
		$"../TempoWheel/tempoDisplay".text = "80"
		$"../TempoWheel/difficultylevel".text = "advanced"
		Globals.bpm = 40

	if result.collider == %TempoTrigger5:
		$"../TempoWheel/tempoDisplay".text = "90"
		$"../TempoWheel/difficultylevel".text = "advanced"
		Globals.bpm = 45

	if result.collider == %TempoTrigger6:
		$"../TempoWheel/tempoDisplay".text = "100"
		$"../TempoWheel/difficultylevel".text = "difficult"
		Globals.bpm = 50

	if result.collider == %TempoTrigger7:
		$"../TempoWheel/tempoDisplay".text = "110"
		$"../TempoWheel/difficultylevel".text = "difficult"
		Globals.bpm = 55

	if result.collider == %TempoTrigger8:
		$"../TempoWheel/tempoDisplay".text = "120"
		$"../TempoWheel/difficultylevel".text = "hardcore!"
		Globals.bpm = 60

	#find collider IDs
	if not result.is_empty():
		print(result.collider)
		#print(result)
