class_name StorageIterator
extends Object


var _storage
var _position: int


func _init(storage) -> void:
	_storage = storage
	_position = 0


func current() -> Node:
	return _storage.get_item(_position)


func next() -> Node:
	_position += 1
	return _storage.get_item(_position)


func has_next() -> bool:
	return _position + 1 < _storage.get_size() 


func reset_position() -> void:
	_position = 0
