class_name LevelManager extends Node2D
@onready var level: Node2D = $Level



func load_level(level_name : String) -> void:
	unload_level()
	if level_name == "ctd":
		var level_res = load("res://CTD_player/CTD_game.tscn")
		var level_ins = level_res.instantiate()
		level.add_child(level_ins)
	elif level_name == "overworld":
		var level_res = load("res://scenes/over_world.tscn")
		var level_ins = level_res.instantiate()
		level.add_child(level_ins)
	
func unload_level() -> void: 
	var lev = level.get_child(0)
	if lev: 
		lev.queue_free()
	
