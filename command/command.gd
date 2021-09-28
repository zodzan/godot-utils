class_name Command
extends Object


var command_object: Object setget set_command_object


func set_command_object(object: Object) -> void:
	command_object = object


func execute(object: Object = null) -> void:
	if is_instance_valid(object):
		_execute(object)
		set_command_object(object)
	elif is_instance_valid(command_object):
		_execute(command_object)


func revert(object: Object = null) -> void:
	if is_instance_valid(object):
		_revert(object)
		set_command_object(object)
	elif is_instance_valid(command_object):
		_revert(command_object)


func _execute(_object: Object) -> void:
	pass


func _revert(_object: Object) -> void:
	pass

