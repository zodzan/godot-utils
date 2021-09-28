class_name ShapeCastComponent
extends CollisionComponent


export(Shape) var shape: Shape setget set_shape
var query_params: PhysicsShapeQueryParameters


func _init() -> void:
	_init_query_parameters()


func _ready() -> void:
	_ready_query_parameters()


func set_collision_mask(mask: int) -> void:
	.set_collision_mask(mask)
	query_params.set_collision_mask(collision_mask)


func set_collide_with_bodies(enable: bool) -> void:
	.set_collide_with_bodies(enable)
	query_params.set_collide_with_bodies(collide_with_bodies)


func set_collide_with_areas(enable: bool) -> void:
	.set_collide_with_areas(enable)
	query_params.set_collide_with_areas(collide_with_areas)


func set_shape(s: Shape) -> void:
	shape = s
	query_params.set_shape(shape)


func set_exclude(exclude: Array) -> void:
	query_params.set_exclude(exclude)


func intersect_shape(xform: Transform = global_transform, 
		max_results: int = 32) -> Array:
	query_params.set_transform(xform)
	var space_state := get_world().get_direct_space_state()
	var intersections: Array = space_state.intersect_shape(query_params, 
			max_results)
	
	var collisions: Array = []
	for i in intersections:
		var collision := i as Dictionary
		collisions.append(_create_collision_ref(collision))
	
	return collisions
	

func _create_collision_ref(collision: Dictionary) -> ShapeCastCollision:
	var shape_collision := ShapeCastCollision.new()
	shape_collision.set_collider(collision[COLLIDER_KEY] as Object)
	shape_collision.set_collider_id(collision[COLLIDER_ID_KEY] as int)
	shape_collision.set_rid(collision[RID_KEY] as RID)
	shape_collision.set_shape(collision[SHAPE_KEY] as int)
	
	return shape_collision


func _init_query_parameters() -> void:
	query_params = PhysicsShapeQueryParameters.new()


func _ready_query_parameters() -> void:
	query_params.set_collision_mask(collision_mask)
	query_params.set_collide_with_bodies(collide_with_bodies)
	query_params.set_collide_with_areas(collide_with_areas)
