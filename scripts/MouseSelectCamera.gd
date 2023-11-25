extends Camera3D

var m_pos = Vector2()

func _input(event):
	if event is InputEventMouse:
		m_pos = event.position
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			raycast_from_mouse(m_pos, 1)

func _process(delta):
	m_pos = get_viewport().get_mouse_position()
	raycast_from_mouse_hover(m_pos, 1)

#raycast on hover
func raycast_from_mouse_hover(m_pos, collision_mask):
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
		$"../LevelWheel/Trigger1".transparency = 0
		$"../LevelWheel/Trigger2".transparency = 0
		$"../LevelWheel/Trigger3".transparency = 0
		$"../LevelWheel/Trigger4".transparency = 0
		$"../LevelWheel/Trigger5".transparency = 0
		$"../LevelWheel/Trigger6".transparency = 0
		$"../LevelWheel/Trigger7".transparency = 0
		$"../LevelWheel/Trigger8".transparency = 0
		$"../TempoWheel/Trigger1".transparency = 0
		$"../TempoWheel/Trigger2".transparency = 0
		$"../TempoWheel/Trigger3".transparency = 0
		$"../TempoWheel/Trigger4".transparency = 0
		$"../TempoWheel/Trigger5".transparency = 0
		$"../TempoWheel/Trigger6".transparency = 0
		$"../TempoWheel/Trigger7".transparency = 0
		$"../TempoWheel/Trigger8".transparency = 0
		return
		
	#level select wheel buttons
	if result.collider == %TriggerShape1:
		$"../LevelWheel/Trigger1".transparency = .5

	if result.collider == %TriggerShape2:
		$"../LevelWheel/Trigger2".transparency = .5

	if result.collider == %TriggerShape3:
		$"../LevelWheel/Trigger3".transparency = .5

	if result.collider == %TriggerShape4:
		$"../LevelWheel/Trigger4".transparency = .5

	if result.collider == %TriggerShape5:
		$"../LevelWheel/Trigger5".transparency = .5

	if result.collider == %TriggerShape6:
		$"../LevelWheel/Trigger6".transparency = .5

	if result.collider == %TriggerShape7:
		$"../LevelWheel/Trigger7".transparency = .5

	if result.collider == %TriggerShape8:
		$"../LevelWheel/Trigger8".transparency = .5
		
	#tempo select wheel
	if result.collider == %TempoTrigger1:
		$"../TempoWheel/Trigger1".transparency = .5

	if result.collider == %TempoTrigger2:
		$"../TempoWheel/Trigger2".transparency = .5

	if result.collider == %TempoTrigger3:
		$"../TempoWheel/Trigger3".transparency = .5

	if result.collider == %TempoTrigger4:
		$"../TempoWheel/Trigger4".transparency = .5

	if result.collider == %TempoTrigger5:
		$"../TempoWheel/Trigger5".transparency = .5

	if result.collider == %TempoTrigger6:
		$"../TempoWheel/Trigger6".transparency = .5

	if result.collider == %TempoTrigger7:
		$"../TempoWheel/Trigger7".transparency = .5

	if result.collider == %TempoTrigger8:
		$"../TempoWheel/Trigger8".transparency = .5
	
#raycast on click
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
		
	#settings
	if result.collider == %settings:
		$"../GUI/settings".visible = true
		
	#level select wheel buttons
	if result.collider == %TriggerShape1:
		$"../LevelWheel/levelName".text = "tutorial"
		$"../LevelWheel/levelDifficulty".text = "beginner"
		Globals.levelName = "tutorial_onewheel"

	if result.collider == %TriggerShape2:
		$"../LevelWheel/levelName".text = "prelude"
		$"../LevelWheel/levelDifficulty".text = "beginner"
		Globals.levelName = "beginner_prelude"

	if result.collider == %TriggerShape3:
		$"../LevelWheel/levelName".text = "vines"
		$"../LevelWheel/levelDifficulty".text = "intermediate"
		Globals.levelName = "intermediate_vines"

	if result.collider == %TriggerShape4:
		$"../LevelWheel/levelName".text = "spinning"
		$"../LevelWheel/levelDifficulty".text = "intermediate"
		Globals.levelName = "intermediate_spinning"

	if result.collider == %TriggerShape5:
		$"../LevelWheel/levelName".text = "hocket canon"
		$"../LevelWheel/levelDifficulty".text = "intermediate"
		Globals.levelName = "intermediate_hocket_canon"

	if result.collider == %TriggerShape6:
		$"../LevelWheel/levelName".text = "whirl"
		$"../LevelWheel/levelDifficulty".text = "advanced"
		Globals.levelName = "advanced_whirl"

	if result.collider == %TriggerShape7:
		$"../LevelWheel/levelName".text = "coming soon!"
		$"../LevelWheel/levelDifficulty".text = "advanced"

	if result.collider == %TriggerShape8:
		$"../LevelWheel/levelName".text = "coming soon!"
		$"../LevelWheel/levelDifficulty".text = "advanced"

	#tempo select wheel
	if result.collider == %TempoTrigger1:
		$"../TempoWheel/difficultylevel".text = "beginner"
		Globals.bpm = 25
		$"../TempoWheel/tempoDisplay".text = str(Globals.bpm * 2)

	if result.collider == %TempoTrigger2:
		$"../TempoWheel/difficultylevel".text = "easy"
		Globals.bpm = 30
		$"../TempoWheel/tempoDisplay".text = str(Globals.bpm * 2)

	if result.collider == %TempoTrigger3:
		$"../TempoWheel/difficultylevel".text = "easy"
		Globals.bpm = 35
		$"../TempoWheel/tempoDisplay".text = str(Globals.bpm * 2)

	if result.collider == %TempoTrigger4:
		$"../TempoWheel/difficultylevel".text = "advanced"
		Globals.bpm = 40
		$"../TempoWheel/tempoDisplay".text = str(Globals.bpm * 2)

	if result.collider == %TempoTrigger5:
		$"../TempoWheel/difficultylevel".text = "advanced"
		Globals.bpm = 45
		$"../TempoWheel/tempoDisplay".text = str(Globals.bpm * 2)

	if result.collider == %TempoTrigger6:
		$"../TempoWheel/difficultylevel".text = "difficult"
		Globals.bpm = 50
		$"../TempoWheel/tempoDisplay".text = str(Globals.bpm * 2)

	if result.collider == %TempoTrigger7:
		$"../TempoWheel/difficultylevel".text = "difficult"
		Globals.bpm = 55
		$"../TempoWheel/tempoDisplay".text = str(Globals.bpm * 2)

	if result.collider == %TempoTrigger8:
		$"../TempoWheel/difficultylevel".text = "hardcore!"
		Globals.bpm = 60
		$"../TempoWheel/tempoDisplay".text = str(Globals.bpm * 2)

	#find collider IDs
	#if not result.is_empty():
		#print(result.collider)
		#print(result)
