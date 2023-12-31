# Run.gd
extends State

var player: Player
var animator: AnimatedSprite2D
var dialog_box: RichTextLabel

func enter(_msg := {}) -> void:
	player = state_machine.player
	animator = state_machine.animator
	dialog_box = state_machine.dialog_box
	
	animator.play("run")


func physics_update(delta: float) -> void:
	# Notice how we have some code duplication between states. That's inherent to the pattern,
	# although in production, your states will tend to be more complex and duplicate code
	# much more rare.
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return

	if Input.is_action_pressed("move_left"):
		player.velocity.x = -player.speed
		animator.flip_h = true
	elif Input.is_action_pressed("move_right"):
		player.velocity.x = player.speed
		animator.flip_h = false
	else:
		player.velocity.x = 0

	player.velocity.y += player.gravity * delta
	player.move_and_slide()

	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Air", {do_jump = true})
	elif Input.is_action_just_pressed("roll"):
		state_machine.transition_to("Roll")
	elif player.velocity.x == 0:
		state_machine.transition_to("Idle")
	if dialog_box.visible:
		state_machine.transition_to("Dialog")
