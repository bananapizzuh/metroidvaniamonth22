extends State

var player: Player
var animator: AnimatedSprite2D
var dialog_box: RichTextLabel

func create_trail():
	add_child(load("res://Scenes/PlayerRollSprite.tscn").instantiate())
	var trail_sprite = get_children()[-1]
	trail_sprite.texture = animator.get_sprite_frames().get_frame_texture(
		animator.get_animation(), animator.get_frame()
	)
	trail_sprite.flip_h = animator.flip_h
	trail_sprite.position = player.position
	var tween = get_tree().create_tween()
	tween.tween_property(trail_sprite, "modulate:a", 0, 1)
	tween.tween_callback(trail_sprite.queue_free)


func enter(_msg := {}) -> void:
	player = state_machine.player
	animator = state_machine.animator
	dialog_box = state_machine.dialog_box
	
	player.can_air_roll = false
	if player.is_on_floor():
		animator.play("roll")
	else:
		animator.play("air_spin")
	animator.frame_changed.connect(create_trail)
	
	player.change_hitbox(Vector2(33, 14), Vector2(-2.5, 9))


func exit():
	animator.frame_changed.disconnect(create_trail)
	player.change_hitbox(player.HITBOX_SIZE, player.HITBOX_POS)


func physics_update(delta: float) -> void:
	
	player.velocity.y += player.gravity * delta

	if animator.get_animation() == "roll":
		if animator.get_frame() == 6:
			state_machine.transition_to("Idle")
	elif animator.get_animation() == "air_spin":
		player.velocity.y = 0
		if animator.get_frame() == 5:
			state_machine.transition_to("Idle")
			
	if dialog_box.visible:
		state_machine.transition_to("Dialog")

	if animator.flip_h:
		player.velocity.x = -player.roll_speed
	elif !animator.flip_h:
		player.velocity.x = player.roll_speed
	player.move_and_slide()
