extends Node3D


const RAY_LENGTH = 100.0;


func _unhandled_input(event):
	var mouse_left = event.is_action_pressed("mouse_left")
	var mouse_right = event.is_action_pressed("mouse_right")
	
	if mouse_left or mouse_right:
		var hit = cast_ray_from_mouse_pointer()
		
		if hit != null:
			var node = hit["collider"]
			if node is MouseInteractive:
				if mouse_left: node.interact_left()
				if mouse_right : node.interact_right()


func cast_ray_from_mouse_pointer(mask = 1):
	var mouse_pos = get_viewport().get_mouse_position();
	var cam = get_viewport().get_camera_3d();
	
	var ray_query : PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.new();
	ray_query.from = cam.project_ray_origin(mouse_pos);
	ray_query.to = ray_query.from + cam.project_ray_normal(mouse_pos) * RAY_LENGTH;
	ray_query.collide_with_areas = true;
	ray_query.collide_with_bodies = true;
	ray_query.collision_mask = mask;
	
	var space = get_world_3d().direct_space_state;
	return space.intersect_ray(ray_query);
