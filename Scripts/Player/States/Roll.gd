extends State

@export var player: Player
@export var animator: AnimatedSprite2D

func enter(_msg := {}) -> void:
	animator.play("roll")

func physics_update(delta: float) -> void:
	if animator.get_frame() == 6:
		state_machine.transition_to("Idle")
	
	if animator.flip_h:	
		player.velocity.x = -player.roll_speed
	elif !animator.flip_h:	
		player.velocity.x = player.roll_speed
	
	player.move_and_slide()

