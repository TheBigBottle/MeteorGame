extends Node2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var level_manager: LevelManager = $"/root/playground/LevelManager"




func _on_restart_pressed() -> void:
	animation_player.play("fadeout")
	



func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	level_manager.load_level("overworld")
