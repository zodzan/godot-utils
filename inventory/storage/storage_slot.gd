class_name StorageSlot
extends Object


signal item_set(item)
signal item_removed(item)

var item: Node setget set_item, get_item
var scene_node: Node setget set_scene_node


func get_item() -> Node:
	return item


func set_item(new_item: Node) -> void:
	if is_instance_valid(item):
		var removed_item: Node = item
		item = null
		_remove_from_scene(removed_item)
		emit_signal("item_removed", removed_item)
	
	item = new_item
	_add_to_scene(new_item)
	emit_signal("item_set", item)


func clear_item() -> void:
	var removed_item: Node = item
	item = null
	_remove_from_scene(removed_item)
	emit_signal("item_removed", removed_item)


func set_scene_node(node: Node) -> void:
	scene_node = node


func empty() -> bool:
	return item == null


func _add_to_scene(item_to_add: Node) -> void:
	if is_instance_valid(scene_node) and !item_to_add.is_inside_tree():
		scene_node.add_child(item_to_add)


func _remove_from_scene(item_to_remove: Node) -> void:
	if is_instance_valid(scene_node) and \
			scene_node.is_a_parent_of(item_to_remove):
		scene_node.remove_child(item_to_remove)
