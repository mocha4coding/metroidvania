extends Node2D

@onready var shift_platform: AnimationPlayer = $shiftPlatform

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		shift_platform.play("up")


func _on_ball_exit_detector_body_exited(body: Node2D) -> void:
	if body is Player:
		shift_platform.play("down")


func _on_ball_entered_detector_body_entered(body: Node2D) -> void:
	if body is Player:
		shift_platform.play("up")
