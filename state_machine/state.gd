class_name State
extends Node
# Contextual behavior base class


# warning-ignore:unused_signal
signal swap_state(next_state_key)
# warning-ignore:unused_signal
signal push_state(next_state_key)
# warning-ignore:unused_signal
signal pop_state()

var state_machine
var actor


func set_state_machine(st_ref) -> void:
	state_machine = st_ref


# set_actor
# Sets the state's actor
func set_actor(actor_ref) -> void:
	actor = actor_ref


# start
# Behavior processing when state has just been activated
func start() -> void:
	pass


# stop
# Behavior processing when state has just been deactivated
func stop() -> void:
	pass


# handle_input
# Behavior processingstriggered when an InputEvent is received
func handle_input(_event: InputEvent) -> void:
	pass


# handle_action
# Standard behavior processing
func handle_action(_delta: float) -> void:
	pass

