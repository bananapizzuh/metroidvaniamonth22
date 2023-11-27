class_name StateMachine
extends Node

signal transitioned(state_name)
@export var initial_state: State
@onready var state: State = initial_state
@export var player: Player
@export var animator: AnimatedSprite2D
@export var dialog_box: RichTextLabel


func _ready() -> void:
	for child in get_children():
		child.state_machine = self
	state.enter()


func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	if not has_node(target_state_name):
		return

	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)
	emit_signal("transitioned", state.name)

	print(target_state_name)
