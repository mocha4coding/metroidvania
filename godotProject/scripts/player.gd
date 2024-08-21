extends CharacterBody2D
class_name Player

const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
@export var ball_mode : Ball
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count = 0
var is_double_jump_collected : bool = false

func _physics_process(delta):
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") :
		if is_on_floor() && jump_count > 0 :
			jump_count = 0
		
		if is_double_jump_collected:
			if jump_count < ball_mode.maxJumps :
				velocity.y = ball_mode.jumpVelocity
				jump_count+= 1
		else : 
			if is_on_floor():
				velocity.y =  ball_mode.jumpVelocity
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func enableDoubleJump() :
	is_double_jump_collected = true
