extends Node3D


const RAY_LENGTH = 100.0;

var hovered_interactive : MouseInteractive = null


func _unhandled_input(event) -> void:
	var mouse_left = event.is_action_pressed("mouse_left")
	var mouse_right = event.is_action_pressed("mouse_right")
	
	var hit = cast_ray_from_mouse_pointer()
	
	if hit:
		var node
		var collider = hit["collider"]
		if collider is MouseInteractive:
			node = collider
		elif collider.owner is MouseInteractive:
			node = collider.owner
		
		if node:
			if node != hovered_interactive:
				hovered_interactive = node
				hovered_interactive.mouse_enter()
			
			if mouse_left: node.interact_left()
			if mouse_right : node.interact_right()
			return
	
	if hovered_interactive != null:
		hovered_interactive.mouse_exit()
		hovered_interactive = null


func cast_ray_from_mouse_pointer(mask = 1) -> Dictionary:
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
