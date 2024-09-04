extends CharacterBody2D
class_name Player

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
@export var ball_mode : Ball
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count = 0
var is_double_jump_collected : bool = false
@onready var ball = $Ball
var ball_mode_index : int = 0
var total_ball_collected : int = 1
var last_checkpoint_position : Vector2 
var moveEnabled: bool = true
func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton:
		print(event)
		
func _physics_process(delta):
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") :
		#print("Jumping")
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
	if moveEnabled:
		if direction:
			velocity.x = direction * ball_mode.horizontalSpeed
		else:
			velocity.x = move_toward(velocity.x, 0, ball_mode.horizontalSpeed)


	#handle ball switch 
	if Input.is_action_just_pressed("switch"):
		handleBallModeSwitch()
	move_and_slide()

func handleBallModeSwitch():
	ball_mode_index = (ball_mode_index + 1) % total_ball_collected
	changeBallMode(ball_mode_index)
	
func enableDoubleJump() :
	is_double_jump_collected = true

func changeBallMode(mode : int = 0) :
	if mode == 1:
		loadStoneBall()
	else :
		loadDefaultBall()

func collectStoneBall():
	total_ball_collected += 1
	ball_mode_index = 1
	changeBallMode(ball_mode_index)
	
	
func loadStoneBall():
	ball_mode = load("res://resources/balls_resources/stone_ball.tres")
	ball.texture = preload("res://assets/playground/stoneBall.png")

func loadDefaultBall():
	ball_mode = load("res://resources/balls_resources/default_ball.tres")
	ball.texture = preload("res://assets/playground/ball.png")

func saveLastPlayerCheckpoint(lastPosition : Vector2):
	last_checkpoint_position = lastPosition
	
func killPlayer():
	global_position = last_checkpoint_position
	

func makePlayerFloatToLocation(targetPosition : Vector2):
	if global_position != targetPosition:
		var floatDirection = global_position.direction_to(targetPosition)
		velocity = floatDirection * ball_mode.horizontalSpeed
