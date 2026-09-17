class_name WolkenManager extends Node2D

@onready var wolke_scene = load("res://scenes/wolke.tscn")
@onready var wolken_timer: Timer = $WolkenTimer
@onready var game_manager: GameManager = %GameManager


@export var wolken_anz : int = 5
var wind_dir : Vector2
var wind_speed : float
var wolken : Array[ Wolke ] = []

var bounds : Array[ Vector2 ]

 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.TileMapBoundsChanged.connect(Updatebounds)
	Updatebounds(GameManager.current_tilemap_bounds)
	wind_speed = game_manager.wind_speed
	wind_dir = game_manager.wind_dir
	wolken_timer.timeout.connect(spawn_wolke)
	wolken_timer.wait_time = randi_range(1, 30)
	wolken_timer.start()
	
	pass # Replace with function body.

var offset = 1
var offi = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if wind_dir != game_manager.wind_dir:
		wind_dir = game_manager.wind_dir 
		updateWolkenDir()
	
	
	delete_wolken()
	pass



func updateWolkenDir() -> void:
	for wolke in wolken: 
		wolke.UpdateWindDir(wind_dir)
		
func updateWolkenSpeed() -> void:
	for wolke in wolken: 
		wolke.UpdateWindSpeed(wind_speed)


func spawn_wolke() -> void:
	## Wolken nur erzeugen wenn weniger als angegebene da sind
	if wolken.size() >= wolken_anz:
		return
	
	var wolke = wolke_scene.instantiate()
	wolke.scale = Vector2.ONE * randf_range(0.75, 1.8)
	if randf() > 0.5:
		wolke.position.x = randf_range(bounds[0].x,bounds[1].x)
		wolke.position.y = bounds[1].y + wolke.texture.get_height() * wolke.scale.y
	else:
		wolke.position.x = bounds[1].x + wolke.texture.get_width() * wolke.scale.x
		wolke.position.y = randf_range(bounds[0].y,bounds[1].y)
	wolke.UpdateWindDir(wind_dir)
	wolke.UpdateWindSpeed(wind_speed)
	wolken.append(wolke)
	add_child(wolke)
	wolken_timer.wait_time = randi_range(1, 60)

func delete_wolken() -> void:
	
	for i in range(wolken.size()): 
		if (wolken[i].position.x > (bounds[1].x + (wolken[i].texture.get_width() * wolken[i].scale.x * 2))) || (wolken[i].position.x < (bounds[0].x - bounds[1].x + (wolken[i].texture.get_width() * wolken[i].scale.x))):
			wolken.pop_at(i).queue_free()
	pass
	
	
func Updatebounds( new_bounds : Array[ Vector2 ] ) -> void:
	if new_bounds ==  []:
		return
	bounds = new_bounds
	pass
