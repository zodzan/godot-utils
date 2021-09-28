class_name RayCastComponent
extends CollisionComponent


const NORMAL_KEY = "normal"
const POSITION_KEY = "position"


func camera_project_ray_origin(screen_point: Vector2) -> Vector3:
	var camera: Camera = get_viewport().get_camera()
	return camera.project_ray_origin(screen_point)


func camera_project_ray_normal(screen_point: Vector2) -> Vector3:
	var camera: Camera = get_viewport().get_camera()
	return camera.project_ray_normal(screen_point)


func intersect_ray(from: Vector3, to: Vector3, exclude: Array = []
		) -> RayCastCollision:
	var space_state := get_world().get_direct_space_state()
	var collision := space_state.intersect_ray(from, to, exclude, 
			collision_mask, collide_with_bodies, collide_with_areas)
	
	return _create_collision_ref(from, to, collision)


func cast_camera_ray(screen_point: Vector2, distance: float, exclude: Array = []
		) -> RayCastCollision:
	var from: Vector3 = camera_project_ray_origin(screen_point)
	var to_dir: Vector3 = camera_project_ray_normal(screen_point)
	var to: Vector3 = from + to_dir * distance

	return intersect_ray(from, to, exclude)


func _create_collision_ref(from: Vector3, to: Vector3, collision: Dictionary
		) -> RayCastCollision:
	var rc_collision: RayCastCollision = RayCastCollision.new()
	rc_collision.set_ray_position(from)
	rc_collision.set_ray_target(to)
	
	if !collision.empty():
		rc_collision.set_collision_normal(collision[NORMAL_KEY] as Vector3)
		rc_collision.set_collision_position(collision[POSITION_KEY] as Vector3)
		rc_collision.set_collider(collision[COLLIDER_KEY] as Object)
		rc_collision.set_collider_id(collision[COLLIDER_ID_KEY] as int)
		rc_collision.set_rid(collision[RID_KEY] as RID)
		rc_collision.set_shape(collision[SHAPE_KEY] as int)
	
	return rc_collision
