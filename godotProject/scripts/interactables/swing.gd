extends Node2D

@onready var ball_position: Marker2D = $swing/BallPosition
var isPlayerOnSwing: bool = false
var player: Player = null
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

@export var timerDuration: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = timerDuration

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: 																														float) -> void:
	
	if isPlayerOnSwing == true:
		player.global_position = ball_position.global_position
		print("player position : ", player.global_position, " marker position : ", ball_position.global_position)
	else:
		if player != null:
			player.makePlayerFloatToLocation(ball_position.global_position)	
		
	if anyMovementDone() && player != null:
		isPlayerOnSwing = false
		player = null
func _on_ball_detector_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body
		
func anyMovementDone() :
	if Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
		return true
		


func _on_ball_seat_body_entered(body: Node2D) -> void:
	if body is Player:
		isPlayerOnSwing = true


func _on_timer_timeout() -> void:
	animation_player.play("swing")
