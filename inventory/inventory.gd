class_name Inventory
extends Node


const SLOT_ITEM_SET_FUNCTION = "_on_slot_item_set"
const SLOT_ITEM_REMOVED_FUNCTION = "_on_slot_item_removed"

var _inventory: Dictionary


func _ready() -> void:
	_ready_storage()


func get_item(storage_key: String, position: int) -> Node:
	var storage: Storage = _inventory.get(storage_key)
	return storage.get_item(position)


func put_item(storage_key: String, position: int, item: Node) -> void:
	var storage: Storage = _inventory.get(storage_key)
	storage.put_item(position, item)


func remove_item(storage_key: String, position: int) -> void:
	var storage: Storage = _inventory.get(storage_key)
	storage.remove_item(position)


func get_storage(storage_key: String) -> Storage:
	return _inventory.get(storage_key) as Storage


func add_storage(storage_key: String, storage: Storage) -> void:
	var p_storage: Storage = _inventory.get(storage_key)
	if !is_instance_valid(p_storage):
		_inventory[storage_key] = storage
		_add_storage_to_scene(storage)


func remove_storage(storage_key: String) -> void:
	var storage: Storage = _inventory.get(storage_key)
	if is_instance_valid(storage):
		_inventory[storage_key] = null
		_remove_storage_from_scene(storage)


func _add_storage_to_scene(storage: Storage) -> void:
	if !storage.is_inside_tree():
		add_child(storage)


func _remove_storage_from_scene(storage: Storage) -> void:
	if is_a_parent_of(storage):
		remove_child(storage)


func _connect_slot(slot: StorageSlot) -> void:
	if !slot.is_connected("item_set", self, SLOT_ITEM_SET_FUNCTION):
		var _conn := slot.connect("item_set", self, SLOT_ITEM_SET_FUNCTION)
	
	if !slot.is_connected("item_removed", self, SLOT_ITEM_REMOVED_FUNCTION):
		var _conn := slot.connect("item_removed", self, 
				SLOT_ITEM_REMOVED_FUNCTION)


func _ready_storage() -> void:
	pass


func _on_slot_item_set(_item: Node) -> void:
	pass


func _on_slot_item_removed(_item: Node) -> void:
	pass

