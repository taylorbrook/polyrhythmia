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
	
	#level select wheel buttons
	if result.collider_id == 33084671161:
		print("button1")

	if result.collider_id == 33135002834:
		print("button2")
		
	if result.collider_id == 33185334566:
		print("button3")
		
	if result.collider_id == 33235666217:
		print("button4")
		
	if result.collider_id == 33285997868:
		print("button5")
		
	if result.collider_id == 33336329519:
		print("button6")
	
	if result.collider_id == 33386661170:
		print("button7")
		
	if result.collider_id == 33436992821:
		print("button8")
	
	#tempo select wheel
	if result.collider_id == 33520878906:
		print("button1")

	if result.collider_id == 33571210557:
		print("button2")
		
	if result.collider_id == 33621542208:
		print("button3")
		
	if result.collider_id == 33671873859:
		print("button4")
		
	if result.collider_id == 33722205510:
		print("button5")
		
	if result.collider_id == 33772537161:
		print("button6")
	
	if result.collider_id == 33822868812:
		print("button7")
		
	if result.collider_id == 33873200463:
		print("button8")
	
	if not result.is_empty():
		print(result.collider_id)


