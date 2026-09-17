extends Node2D
@onready var player: Player = $"../../Player"
@onready var anweisung: Label = $Anweisung
@onready var hovertext: AnimationPlayer = $Hovertext
@onready var fade: AnimationPlayer = $Fade







func _on_area_2d_body_entered(_body: Node2D) -> void:
	if _body is CharacterBody2D:
		player.OnStation()
		fade.play("fadein")
		anweisung.visible = true
		hovertext.play("hovertext")
		
		

func _on_area_2d_body_exited(_body: Node2D) -> void:
	if _body is CharacterBody2D:
		player.OffStation()
		fade.play("fadeout")
		
		


func _on_fade_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fadeout":
		hovertext.stop()
