extends State

# If we get a message asking us to jump, we jump.

@export var player: Player
@export var animator: AnimatedSprite2D

func enter(msg := {}) -> void:
	if msg.has("do_jump"):
		animator.play("jump")
		player.velocity.y = -player.jump_force
		


func physics_update(delta: float) -> void:
	# Horizontal movement.
	if Input.is_action_pressed("move_left"):
		player.velocity.x = -player.speed
		animator.flip_h = true
	elif Input.is_action_pressed("move_right"):
		player.velocity.x = player.speed
		animator.flip_h = false
	else:
		player.velocity.x = 0	
	# Vertical movement.
	player.velocity.y += player.gravity * delta
	player.move_and_slide()

	# Landing.
	if player.is_on_floor():
		animator.play("land")
		if player.velocity.x == 0:
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
