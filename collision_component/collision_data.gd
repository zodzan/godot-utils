class_name CollisionData
extends Reference


var collider: Object
var collider_id: int
var rid: RID
var shape: int


func set_collider(object: Object) -> void:
	collider = object


func set_collider_id(id: int) -> void:
	collider_id = id


func set_rid(r: RID) -> void:
	rid = r


func set_shape(shape_idx: int) -> void:
	shape = shape_idx


func get_collider() -> Object:
	return collider


func get_collider_id() -> int:
	return collider_id


func get_rid() -> RID:
	return rid


func get_shape() -> int:
	return shape
