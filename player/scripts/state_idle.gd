class_name State_Idle extends State

@onready var walk: State = $"../walk"
@onready var interact: State = $"../interact"




## Whats happens when the player enters this state
func Enter() -> void: 
	player.UpdateAnimation("idle")
	pass
	
func Exit() -> void:
	pass

## What happens during the _process update in this State?
func Process( _delta : float ) -> State:
	if not player.direction == Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null

## What happens during the _physics_process update in this State? 	
func Physics( _delta : float) -> State:
	return null

## What happens with input events in this 
func HandleInput( _event: InputEvent) -> State:
	if _event.is_action_pressed("interact"):
		return interact
	return null
