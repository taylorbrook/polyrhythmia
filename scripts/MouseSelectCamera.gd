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
	print(result)
	
	return space_state.intersect_ray(query)
