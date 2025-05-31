extends CharacterBody2D

const SPEED = 140.0
const JUMP_VELOCITY = -300.0
const CLIMB_SPEED = 90.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D
@onready var ladder_raycast_up = $LadderRayCastUp
@onready var ladder_raycast_down = $LadderRayCastDown
@onready var collision = $CollisionShape2D

var on_ladder = false
var is_dead = false

func _physics_process(delta):
	# If player is dead: apply gravity and let them fall
	if is_dead:
		velocity.y += gravity * delta
		move_and_slide()
		return

	# Climb ladder logic
	if ((ladder_raycast_up.is_colliding() or ladder_raycast_down.is_colliding()) and
		(Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down"))):
		on_ladder = true
	elif not (ladder_raycast_up.is_colliding() or ladder_raycast_down.is_colliding()):
		on_ladder = false

	if on_ladder:
		handle_ladder_movement()
	else:
		handle_normal_movement(delta)

	move_and_slide()

func handle_normal_movement(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	update_sprite(direction)

func handle_ladder_movement():
	if Input.is_action_just_pressed("jump"):
		on_ladder = false
		velocity.y = JUMP_VELOCITY
		return

	if Input.is_action_pressed("move_up"):
		velocity.y = -CLIMB_SPEED
	elif Input.is_action_pressed("move_down"):
		velocity.y = CLIMB_SPEED
	else:
		velocity.y = 0

	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	update_sprite(direction, true)

func update_sprite(direction: float, climbing: bool = false) -> void:
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	if climbing:
		animated_sprite.play("idle")  # Change to "climb" if you have it
	elif is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("Run")
	else:
		animated_sprite.play("Jump")

# ✅ Called from killzone.gd
func die():
	if is_dead:
		return
	is_dead = true
	animated_sprite.play("death")
	collision.disabled = true  # Let the player fall through the ground
	velocity.x = 0  # Stop horizontal movement
	
	$DeathSound.play()
