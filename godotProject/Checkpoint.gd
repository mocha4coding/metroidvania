extends Node2D

var player : Player
var lastLocation : Vector2
@onready var marker_2d = $Marker2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body is Player:
		player = body
		#lastLocation = player.global_position
		player.saveLastPlayerCheckpoint(marker_2d.global_position)
