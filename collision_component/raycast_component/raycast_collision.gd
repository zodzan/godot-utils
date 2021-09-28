class_name RayCastCollision
extends CollisionData


var ray_position: Vector3
var ray_target: Vector3

var collision_normal: Vector3
var collision_position: Vector3


func set_ray_position(position: Vector3) -> void:
	ray_position = position


func set_ray_target(position: Vector3) -> void:
	ray_target = position


func set_collision_normal(normal: Vector3) -> void:
	collision_normal = normal


func set_collision_position(position: Vector3) -> void:
	collision_position = position


func collided() -> bool:
	return collider != null


func get_ray_position() -> Vector3:
	return ray_position


func get_ray_target() -> Vector3:
	return ray_target


func get_collision_normal() -> Vector3:
	return collision_normal


func get_collision_position() -> Vector3:
	return collision_position

