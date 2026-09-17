extends Node2D


var wind_dir : Vector2 = Vector2(Vector2.LEFT + Vector2.UP)
var wind_speed : float = randf_range(0.05, 0.3)


var current_tilemap_bounds : Array[ Vector2 ]
signal TileMapBoundsChanged(bounds: Array[ Vector2 ])


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#viewportsize = get_viewport().get_visible_rect().size
	#mapsize = map_1.get_used_rect().position * map_1.rendering_quadrant_size
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	pass

func ChangeTileMapBounds( bounds: Array[ Vector2 ] ) -> void: 
	current_tilemap_bounds = bounds
	TileMapBoundsChanged.emit( bounds )
