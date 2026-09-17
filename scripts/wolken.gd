class_name Wolke extends Sprite2D

@onready var schatten: Sprite2D = $Schatten

var wind_dir : Vector2 = Vector2.ZERO
var wind_speed_offset : float = randf_range(0.005, 0.05)

var wind_speed : float = 0
var offsetdir = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	
	# Wolken wabern
	#wolke.position += wind_dir * wind_speed
	#if offset.y > 10 || offset.y < 0:
	#	offsetdir *= -1
	#
	#offset.y += offsetdir
	#schatten.offset.y += offsetdir 
	pass
	
	
	
func UpdateWindDir(new_wind_dir : Vector2) -> void:
	wind_dir = new_wind_dir
func UpdateWindSpeed(new_wind_speed : float) -> void:
	wind_speed = new_wind_speed + wind_speed_offset
