extends Area2D

@export var speed = 100

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.health -= 1
		print(body.health)
		queue_free()
		
func _process(delta):
	var flip_h = get_parent().flip_h
	
	if flip_h:
		position.x -= speed * delta
	else:
		position.x += speed * delta
