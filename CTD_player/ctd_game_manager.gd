class_name CTDGameManager extends Node

var arbeitslänge : float = 0
var zugkraft : float = 1
var geschwindigkeit : float = 0

var tiefe : float = 1800
var ctd_dir : Vector2 = Vector2.ZERO
var lebenspunkte = 100


var maxzugkraft : float = 10
var maxgeschwindigkeit : float = 1.5

var startbound : int = 55
var maxbound : int = 337
var leftbound : int = 413
var rightbound : int = 572

var gameover_state : bool = false



@onready var hindernis_scene = load("res://CTD_player/Hindernis.tscn")
var hindernisse : Array[ Hindernis ] = []
var num_hindernisse : int = 0

@onready var geschwindigkeit_anz: Label = $"../WindenDisplay/Display/Labels/GeschwindigkeitAnz"
@onready var arbeitslänge_anz: Label = $"../WindenDisplay/Display/Labels/ArbeitslängeAnz"
@onready var zugkraft_anz: Label = $"../WindenDisplay/Display/Labels/ZugkraftAnz"
@onready var tiefe_anz: Label = $"../WindenDisplay/Display/Labels/TiefeAnz"
@onready var anzeigen_timer: Timer = $AnzeigenTimer
@onready var gas_hebel: Sprite2D = $"../Hebel/GasHebel"
@onready var schwenk_hebel: Sprite2D = $"../Hebel/SchwenkHebel"

@onready var hindernis_timer: Timer = $HindernisTimer

@onready var hintergrund_blau: Sprite2D = $"../Blau"
@onready var damage_stufe1_animplayer: AnimationPlayer = $"../schäden/stufe1/AnimationPlayer"


signal gotHit()



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	updateAnzeigen()
	anzeigen_timer.timeout.connect(updateAnzeigen)
	anzeigen_timer.wait_time = 0.07
	anzeigen_timer.start()
	
	hindernis_timer.timeout.connect(spawn_hindernis)
	hindernis_timer.wait_time = randf_range(0.5, 3)
	hindernis_timer.start()
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not gameover_state:
		checkHealth()
		berechneHebel()
		delete_hindernisse()
		berechneHintergrund()


## checke ob das Spiel zu ende ist
func checkHealth() -> void:
	
	if zugkraft >= (maxzugkraft / 2):
		damage_stufe1_animplayer.play("rauch")
	
	
	if zugkraft >= maxzugkraft:
		anzeigen_timer.stop()
		hindernis_timer.stop()
		gameover_state = true
		var gameoverscene = load("res://CTD_player/game_over.tscn")
		var gameoverscreen = gameoverscene.instantiate();
		gameoverscreen.position.x = 0
		gameoverscreen.position.y = -400
		gameoverscreen.z_index = 10
		add_child(gameoverscreen)

func berechneHebel() -> void:
	
	
	#### Frames für den GasHebel
	var vel_pro : float = geschwindigkeit / maxgeschwindigkeit
	if vel_pro < 0.15:
		gas_hebel.frame = 0
	elif vel_pro < 0.6:
		gas_hebel.frame = 1
	else:
		gas_hebel.frame = 2
		
	
	#### Frames für den SchwenkHebel
	if ctd_dir == Vector2.LEFT:
		schwenk_hebel.frame = 3
	elif ctd_dir == Vector2.RIGHT:
		schwenk_hebel.frame = 1
	else:
		schwenk_hebel.frame = 0
		


func calcGeschwindigkeit(posy : float) -> void:
	var y : float = posy
	var vel_pro : float = 0
	var tempgeschwindigkeit
	
	if y < startbound:
		vel_pro = 0
	elif y >= startbound && y < maxbound:
		vel_pro = (y - startbound) / (maxbound - startbound)
	else:
		vel_pro = 1
	
	tempgeschwindigkeit =  vel_pro * maxgeschwindigkeit
	if geschwindigkeit != tempgeschwindigkeit:
		geschwindigkeit = tempgeschwindigkeit
		for hin in hindernisse:
			hin.updateSpeed(geschwindigkeit)
		

func calcArbeitslänge() -> void:
	arbeitslänge += geschwindigkeit

func updateAnzeigen() -> void:
	calcArbeitslänge()
	
	geschwindigkeit_anz.text = str("%2.1f" % geschwindigkeit, "m/s")
	
	### Zugrkaft
	zugkraft_anz.text = str("%2.1f" % zugkraft, "kN/", maxzugkraft, "kN")
	var hsvvalue = 0.4 - ((zugkraft/maxzugkraft) * 0.4 )
	zugkraft_anz.modulate =Color.from_hsv(hsvvalue,1,0.8)
	
	
	arbeitslänge_anz.text = str("%2.1f" % arbeitslänge," m")
	tiefe_anz.text = str(tiefe)

func updateCtdDir(newdir : Vector2) -> void:
	ctd_dir = newdir


func hit( id : int) -> void:
	gotHit.emit()
	zugkraft += 1
	for i in range(0, hindernisse.size()):
		if hindernisse[i].id == id:
			hindernisse[i].playdie()
			hindernisse.pop_at(i)
			break


func spawn_hindernis() -> void:
	if geschwindigkeit > 0:
		var hindernis = hindernis_scene.instantiate()
		var maxscale = 0.7
		var scalefac = randf_range(0.3, maxscale)
		hindernis.scale = Vector2.ONE * scalefac
		hindernis.position.x = randf_range(leftbound, rightbound)
		hindernis.position.y = 95+maxbound+50
		num_hindernisse += 1
		hindernis.setId(num_hindernisse)
		
		hindernisse.append(hindernis)
		hindernis.setScale(scalefac, maxscale)
		hindernis.updateSpeed(geschwindigkeit)
		add_child(hindernis)
		hindernis_timer.wait_time = randf_range(0.5, 3)

func delete_hindernisse() -> void:
	for i in range(0, hindernisse.size()):
		if hindernisse[i].position.y < -100:
			hindernisse.pop_at(i).queue_free()
			break

func berechneHintergrund() -> void:
	var OldRange = (tiefe - 0)  
	var NewRange = (0.667 - 0.556)  
	var hsvvalue : float = (((arbeitslänge - 0) * NewRange) / OldRange) + 0.556
	hintergrund_blau.modulate = Color.from_hsv(hsvvalue, 1.0, 0.7, 1.0)
