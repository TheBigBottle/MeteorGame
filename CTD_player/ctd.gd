class_name CTD extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const friction: int = 8
const acceleration: int = 7

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO



const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var ctd_game_manager: CTDGameManager = %CTDGameManager





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ctd_game_manager.gotHit.connect(gotHit)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
	
	
func _physics_process(_delta: float) -> void:
		#direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	#direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	direction = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	).normalized()
	
	var lerp_weight = _delta * (acceleration if direction else friction)
	velocity = lerp(velocity, direction * SPEED, lerp_weight)
	#velocity = direction * SPEED
	
	rotation_degrees = lerp(0, 45,velocity.x / SPEED)
	
	
	setGeschwindigkeit(position.y)
	ctd_game_manager.updateCtdDir(direction)
	
	
	
	move_and_slide()




func setGeschwindigkeit(pos : float) -> void:
	ctd_game_manager.calcGeschwindigkeit(pos)
	pass

func gotHit() -> void:
	animation_player.play("hit")
	if sprite_2d.frame < (sprite_2d.hframes - 1):
		sprite_2d.frame = sprite_2d.frame + 1
	pass
