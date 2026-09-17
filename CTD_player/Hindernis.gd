class_name Hindernis extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var geschwindigkeit = 0
var scalefac : float = 0
var maxscale : float = 0
var id : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position.y -= geschwindigkeit * (1 + (maxscale - scalefac))
	pass

func updateSpeed(neue_geschwin : float) -> void:
	geschwindigkeit = neue_geschwin

func setScale(newscale : float, newmaxscale : float) -> void: 
	scalefac = newscale
	maxscale = newmaxscale

func setId(newid : int) -> void:
	id = newid
	
func playdie() -> void: 
	animation_player.play("shrink")
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "shrink":
		queue_free()
