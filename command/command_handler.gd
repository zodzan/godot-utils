class_name CommandHandler
extends Node


enum CommandAction {EXECUTE, REVERT}

const COMMAND_QUEUED_HANDLER_FUNC = "_on_command_queued"
const COMMAND_LIST_QUEUED_HANDLER_FUNC = "_on_command_list_queued"

var command_object: Object setget set_command_object


func set_command_object(object: Object) -> void:
	command_object = object


func _on_command_list_queued(action: int, commands: Array) -> void:
	match action:
		CommandAction.EXECUTE:
			for c in commands:
				var command := c as Command
				command.execute(command_object)
		CommandAction.REVERT:
			for c in commands:
				var command := c as Command
				command.revert(command_object)


func _on_command_queued(action: int, command: Command) -> void:
	match action:
		CommandAction.EXECUTE:
			command.execute(command_object)
		CommandAction.REVERT:
			command.execute(command_object)
