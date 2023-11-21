class_name Player
extends CharacterBody2D

@export var gravity = 980
@export var speed = 500
@export var jump_force = 600
@export var roll_speed = 750
@export var air_roll_unlocked = false
@export var can_air_roll = false

func change_dialog(text):
	$CanvasLayer/Label.visible = true
	$CanvasLayer/Label.text = text
	print("change dialog")

func _physics_process(delta):
	if $RayCast2D.is_colliding():
		var object = $RayCast2D.get_collider()
		if object.is_in_group("Interactable") && Input.is_action_pressed('ui_interact'):
			if object.is_in_group("Dialog"):
				change_dialog("text")
