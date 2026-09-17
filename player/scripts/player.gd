class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.RIGHT
var direction : Vector2 = Vector2.ZERO

var player_on_station: bool = false

const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]
#const DIR_2 = [ Vector2.RIGHT, Vector2.LEFT]

@onready var game_master: Node2D = $"../../../../GameMaster"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var animation_tree: AnimationTree = $AnimationTree





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = game_master.player_pos[0]
	position.y = game_master.player_pos[1]
	state_machine.Initialize(self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	#direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	direction = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	).normalized()
	

	
	if Input.is_action_just_pressed("interact"):
		Interact()
	
func _physics_process(_delta: float) -> void:
	move_and_slide()

func SetDirection() -> bool:
	if direction == Vector2.ZERO:
		return false
	
	#calculate Direction in 4 directions
	var direction_id : int = int( round( ( direction + cardinal_direction * 0.1 ).angle() / TAU * DIR_4.size() ) )
	var new_direction = DIR_4[direction_id]
	
	#var direction_id : int = int( round( ( direction + cardinal_direction * 0.1 ).angle() / TAU * DIR_2.size() ) )
	#var new_direction = DIR_2[direction_id]
	
	#sprite_2d.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	
	
	
		
	if new_direction == cardinal_direction:
		return false
		
	cardinal_direction = new_direction
	#DirectionChanged.emit( new_direction )
	
	return true
	

func Interact() -> void: 
	pass

func OnStation() -> void:
	player_on_station = true
func OffStation() -> void:
	player_on_station = false


func UpdateAnimation( state : String ) -> void: 
	#animation_player.play(state + "_" + AnimDirection())
	if state == "move":
		if not direction.x == 0:
			animation_tree.set("parameters/blend_position", Vector2(direction.x,0))
		else:
			animation_tree.set("parameters/blend_position", Vector2(0,direction.y))
	elif state == "idle":
		pass
	elif state == "interact":
		pass
	
	
func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		#return "down"
		return "side"
	elif cardinal_direction == Vector2.UP:
		return "up"
		#return "side"
	else:
		return "side"
