extends Node2D

const SPEED = 60
var direction := 1  # 1 = right, -1 = left

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_down_right = $RayCastDownRight
@onready var ray_cast_down_left = $RayCastDownLeft
@onready var animated_sprite = $AnimatedSprite2D

func _process(delta):
	# Wall collision check
	if ray_cast_right.is_colliding():
		direction = -1
	elif ray_cast_left.is_colliding():
		direction = 1

	# Platform edge detection
	if direction == 1 and not ray_cast_down_right.is_colliding():
		direction = -1
	elif direction == -1 and not ray_cast_down_left.is_colliding():
		direction = 1

	# Move enemy
	position.x += direction * SPEED * delta

	# Flip sprite
	animated_sprite.flip_h = direction < 0
