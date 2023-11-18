extends State

@export var player: Player
@export var animator: AnimatedSprite2D

func enter(_msg := {}) -> void:
	player.velocity = Vector2.ZERO
	


func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return
		
	if animator.get_animation() == "land":
		if animator.get_frame() == 6:
			animator.play("idle")
	else:
		animator.play("idle")

	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Air", {do_jump = true})
	elif Input.is_action_just_pressed("roll"):
		state_machine.transition_to("Roll")
	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_machine.transition_to("Run")
		
