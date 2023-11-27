class_name Player
extends CharacterBody2D

@export var gravity = 500
@export var speed = 300
@export var jump_force = 275
@export var roll_speed = 350
@export var health = 6
@export var air_roll_unlocked = false
@export var can_air_roll = false

const HITBOX_SIZE = Vector2(17, 29)
const HITBOX_POS = Vector2(-1.5, 1.5)

func create_dialog(text):
	$HUD/RichTextLabel.visible = true
	$HUD/RichTextLabel.text = text
	
func change_hitbox(size: Vector2, pos: Vector2):
	$CollisionShape2D.shape.size = size
	$CollisionShape2D.position = pos

func _process(_delta):
	if $AnimatedSprite2D.flip_h:
		$RayCast2D.rotation = 180
	else:
		$RayCast2D.rotation = 0
		
	
	var interact = Input.is_action_just_pressed("ui_interact")
	
	if $HUD/RichTextLabel.visible and interact:
		$HUD/RichTextLabel.visible = false
		interact = false
		
	if $RayCast2D.is_colliding():
		var obj = $RayCast2D.get_collider()
		if obj.is_in_group("Interactable") and interact and $StateMachine.state.name != "Roll":
			if obj.is_in_group("Dialog"):
				create_dialog(obj.get_dialog())
	
	
