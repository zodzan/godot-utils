class_name CommandHistory
extends Object


var commands: Array
var position: int


func add(command: Command) -> void:
	if position < commands.size():
		commands = commands.slice(0, position)
	commands.push_back(command)
	position = commands.size() - 1


func undo(object: Object = null) -> void:
	if position >= 0:
		var command: Command = commands[position]
		command.revert(object)
		position -= 1


func redo(object: Object = null) -> void:
	if position + 1 < commands.size():
		var command: Command = commands[position + 1]
		command.execute(object)
		position += 1


func undo_all(object: Object = null) -> void:
	for i in range(position, -1, -1):
		var command: Command = commands[i]
		command.revert(object)
	position = 0


func redo_all(object: Object = null) -> void:
	for i in range(position, commands.size()):
		var command: Command = commands[i]
		command.execute(object)
	position = commands.size() - 1

