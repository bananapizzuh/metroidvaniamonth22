extends State

var player: Player
var animator: AnimatedSprite2D
var dialog_box: RichTextLabel

func jump():
	player.velocity.y = -player.jump_force
	player.can_air_roll = true


func enter(msg := {}) -> void:
	
	player = state_machine.player
	animator = state_machine.animator
	dialog_box = state_machine.dialog_box
	animator.play("jump")
	if msg.has("do_jump"):
		jump()
	else:
		animator.frame = 2


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
	elif Input.is_action_pressed("roll") and player.air_roll_unlocked and player.can_air_roll:
		state_machine.transition_to("Roll")
		
	if dialog_box.visible:
		state_machine.transition_to("Dialog")
