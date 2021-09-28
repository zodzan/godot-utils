class_name StateMachine
extends Node
# States handler


var actor

var keys: Array
var states: Dictionary
var stack: Array
var state: State


func _ready() -> void:
	_ready_states()


func set_actor(actor_ref) -> void:
	actor = actor_ref
	for s in states.values():
		if s is State:
			s.set_actor(actor_ref)


# handle_input
# Used by the state machine owner when an InputEvent is received 
func handle_input(event: InputEvent) -> void:
	if is_instance_valid(state):
		state.handle_input(event)


# update
# Standard state behavior processing
func update(delta: float) -> void:
	if is_instance_valid(state):
		state.handle_action(delta)


# swap_state
# Swaps the current state with another state
func swap_state(next_state_key: String) -> void:
	if states.has(next_state_key):
		var next_state: State = states[next_state_key]
		_swap(next_state_key, next_state)


# push_state
# Changes the current state with another state
# The current state is kept in the states stack
func push_state(next_state_key: String) -> void:
	if states.has(next_state_key):
		var next_state: State = states[next_state_key]
		_push(next_state_key, next_state)


# pop_state
# Changes the current state with the state at the top of the states stack
func pop_state() -> void:
	_pop()


# add_state
# Adds a new pair of key/value (String/State) into the state dictionary
# Does not add the pair if the key already exists
func add_state(new_key: String, new_state: State) -> void:
	if !states.has(new_key):
		if is_instance_valid(actor):
			new_state.set_actor(actor)
		new_state.set_state_machine(self)
		_connect_state_signals(new_state)
		states[new_key] = new_state


# _swap
# Handles the state swapping process
func _swap(next_state_key: String, next_state: State) -> void:
	if is_instance_valid(state):
		state.stop()
	
	if stack.back():
		stack[stack.size() - 1] = next_state_key
	else:
		stack.push_back(next_state_key)
	
	state = next_state
	next_state.start()
	

# _push
# Handles the state pushing process
func _push(next_state_key: String, next_state: State) -> void:
	if is_instance_valid(state):
		state.stop()
	
	stack.push_back(next_state_key)
	state = next_state
	next_state.start()


# _pop
# Handles the state popping process
func _pop() -> void:
	if is_instance_valid(state):
		state.stop()

	var next_state_key: String
	var next_state: State
	var has_next_state_key: bool = stack.pop_back() and stack.back()
	if has_next_state_key:
		next_state_key = stack.back()
		if states.has(next_state_key):
			next_state = states[next_state_key]
	
	state = next_state
	if is_instance_valid(next_state):
		next_state.start()


# _connect_state_signals
# Connects a state's signals to the state machine
func _connect_state_signals(c_state: State) -> void:
	if !c_state.is_connected("swap_state", self, "_on_swap_state"):
		var _swap := c_state.connect("swap_state", self, "_on_swap_state")
	if !c_state.is_connected("push_state", self, "_on_push_state"):
		var _push := c_state.connect("push_state", self, "_on_push_state")
	if !c_state.is_connected("pop_state", self, "_on_pop_state"):
		var _pop := c_state.connect("pop_state", self, "_on_pop_state")


# _disconnect_state_signals
# Disconnects a state's signals to the state machine
func _disconnect_state_signals(d_state: State) -> void:
	if d_state.is_connected("swap_state", self, "_on_swap_state"):
		d_state.disconnect("swap_state", self, "_on_swap_state")
	if d_state.is_connected("push_state", self, "_on_push_state"):
		d_state.disconnect("push_state", self, "_on_push_state")
	if d_state.is_connected("pop_state", self, "_on_pop_state"):
		d_state.disconnect("pop_state", self, "_on_pop_state")


func _ready_states() -> void:
	var state_list: Array = $States.get_children()
	for i in state_list.size():
		var s := state_list[i] as State
		add_state(keys[i], s)


# _on_swap_state
# swap_state signal method
func _on_swap_state(next_state_key: String) -> void:
	swap_state(next_state_key)


# _on_push_state
# push_state signal method
func _on_push_state(next_state_key: String) -> void:
	push_state(next_state_key)


# _on_pop_state
# pop_state signal method
func _on_pop_state() -> void:
	pop_state()

