class_name State_Interact extends State

@onready var walk: State = $"../walk"
@onready var idle: State_Idle = $"../idle"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var level_manager: LevelManager = $"/root/playground/LevelManager"
@onready var game_master: Node2D = $"../../../../../../GameMaster"


var interacting: bool = false

## Whats happens when the player enters this state
func Enter() -> void: 
	player.velocity = Vector2.ZERO
	player.UpdateAnimation("interact")
	interacting = true
	animation_player.animation_finished.connect(Endinteract)
	game_master.UpdatePos(player.position.x, player.position.y)
	if player.player_on_station:
		level_manager.load_level("ctd")
	
	pass
	
func Exit() -> void:
	interacting = false
	animation_player.animation_finished.disconnect(Endinteract)
	pass

## What happens during the _process update in this State?
func Process( _delta : float ) -> State:
	if not interacting:
		if not player.direction == Vector2.ZERO:
			return walk
		elif player.direction == Vector2.ZERO:
			return idle
	return null

## What happens during the _physics_process update in this State? 	
func Physics( _delta : float) -> State:
	return null

## What happens with input events in this 
func HandleInput( _event: InputEvent) -> State:
	return null


func Endinteract(_newAnimName : String) -> void:
	interacting = false
