extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -305.0
const FALL_THRESHOLD = 200

@onready var animated_sprite = $AnimatedSprite2D
@onready var game_manager = %GameManager
@onready var coyote_timer = $CoyoteTimer

var last_height = 0;
var msg_timer = 0;

func _process(delta: float) -> void:
	# Tell the game manager the player's height
	game_manager.set_prog(transform.get_origin().y)
	
	# Decrease the message timer
	if (msg_timer > 0): msg_timer -= delta

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() || !coyote_timer.is_stopped()):
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations & handle height
	if is_on_floor():
		# Check if the message timer ended
		if msg_timer <= 0:
			# Detect if a fall actually happened
			if transform.get_origin().y - last_height > FALL_THRESHOLD:
				# Set a custom message
				game_manager.custom_message("bro fell")
				print("Bro fell")
				msg_timer = 2
			else:
				# Set the message to default
				game_manager.custom_message("none")
		
		# Set the last height when touching a block
		last_height = transform.get_origin().y;
		
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	

	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Detect if the player is on the floor
	var was_on_floor = is_on_floor()
	
	move_and_slide()
	
	# Run Coyote Jump timer if no longer touching the floor
	if was_on_floor && !is_on_floor():
		coyote_timer.start()
