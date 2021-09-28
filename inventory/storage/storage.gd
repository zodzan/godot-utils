class_name Storage
extends Node


export(int) var size: int

var slots: Array


func _ready() -> void:
	_init_slots()


func get_item(position: int) -> Node:
	var slot: StorageSlot = slots[position]
	return slot.get_item()


func put_item(position: int, item: Node) -> void:
	var slot: StorageSlot = slots[position]
	slot.set_item(item)


func remove_item(position: int) -> void:
	var slot: StorageSlot = slots[position]
	if !slot.empty():
		slot.clear_item()


func slot_is_empty(position: int) -> bool:
	var slot: StorageSlot = slots[position]
	return slot.empty()


func get_size() -> int:
	return size


func create_iterator() -> StorageIterator:
	return StorageIterator.new(self)


func resize(new_size: int, fill_slots: bool = true) -> void:
	var prev_size: int = slots.size()
	if new_size < prev_size:
		for i in range(new_size, prev_size):
			_delete_slot(i)
		slots.resize(new_size)
	elif new_size > prev_size:
		slots.resize(new_size)
		if fill_slots:
			for i in range(prev_size, new_size):
				_create_slot(i)
	size = new_size
	

func add_slot(slot: StorageSlot) -> void:
	slots.append(slot)


func put_slot(position: int, slot: StorageSlot) -> void:
	if is_instance_valid(slots[position]):
		_delete_slot(position)
	slots[position] = slot


func remove_slot(position: int) -> void:
	_delete_slot(position)
	slots.remove(position)


func build_slots(slot_list: Array) -> void:
	for i in slot_list.size():
		var slot: StorageSlot = slot_list[i]
		put_slot(i, slot)	


func free() -> void:
	_delete_slots()
	.free()


func _create_slot(position: int) -> void:
	slots[position] = StorageSlot.new()


func _delete_slot(position: int) -> void:
	var slot: StorageSlot = slots[position]
	slot.free()


func _delete_slots() -> void:
	for s in slots:
		var slot := s as StorageSlot
		slot.free()


func _init_slots() -> void:
	resize(size)
