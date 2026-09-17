class_name GameMaster extends Node2D

var player_pos : Array[float] = [0.0,0.0]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func UpdatePos(x : float, y: float) -> void: 
	player_pos = [x,y]
