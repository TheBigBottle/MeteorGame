extends Area2D


@onready var ctd_game_manager: CTDGameManager = $"../../../CTDGameManager"
@onready var hindernis: Hindernis = $".."



func _on_body_entered(_body: Node2D) -> void:
	print("hit")
	ctd_game_manager.hit(hindernis.id)
	
	pass # Replace with function body.
