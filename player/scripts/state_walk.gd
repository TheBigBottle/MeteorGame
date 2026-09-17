class_name State_Walk extends State

@export var move_speed : float = 75.0

@onready var idle: State = $"../idle"
@onready var interact: State_Interact = $"../interact"



## Whats happens when the player enters this state
func Enter() -> void: 
	player.UpdateAnimation("move")
	pass
	
func Exit() -> void:
	pass

## What happens during the _process update in this State?
func Process( _delta : float ) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	player.velocity = player.direction * move_speed
	
	if player.SetDirection():
		player.UpdateAnimation("move")
	
	return null

## What happens during the _physics_process update in this State? 	
func Physics( _delta : float) -> State:
	return null

## What happens with input events in this 
func HandleInput( _event: InputEvent) -> State:
	if _event.is_action_pressed("interact"):
		return interact
	return null
