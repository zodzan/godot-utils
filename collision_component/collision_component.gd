class_name CollisionComponent
extends Spatial


const COLLIDER_KEY = "collider"
const COLLIDER_ID_KEY = "collider_id"
const RID_KEY = "rid"
const SHAPE_KEY = "shape"

const DEFAULT_COLLISION_MASK = 0b0
const DEFAULT_COLLIDE_WITH_BODIES = true
const DEFAULT_COLLIDE_WITH_AREAS = false

export(int, LAYERS_3D_PHYSICS) var collision_mask: int = DEFAULT_COLLISION_MASK
export(bool) var collide_with_bodies: bool = DEFAULT_COLLIDE_WITH_BODIES
export(bool) var collide_with_areas: bool = DEFAULT_COLLIDE_WITH_AREAS


func set_collision_mask(mask: int) -> void:
	collision_mask = mask


func set_collide_with_bodies(enable: bool) -> void:
	collide_with_bodies = enable


func set_collide_with_areas(enable: bool) -> void:
	collide_with_areas = enable
