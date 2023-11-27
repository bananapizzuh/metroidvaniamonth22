extends Area2D

@export var snowball_speed = 200

var timer_zero = true
var flip_h = true

func _process(delta):
	if $RayCast2D.is_colliding():
		var obj = $RayCast2D.get_collider()
		if obj.is_in_group("Player") and timer_zero:
			$Timer.start()
			timer_zero = false
			throw_snowball()
			
			
func throw_snowball():
	add_child(load("res://Scenes/PenguinSnowball.tscn").instantiate())

func _on_timer_timeout():
	timer_zero = true
