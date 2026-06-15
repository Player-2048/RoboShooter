extends Node

var step_sfx: AudioStreamPlayer
var jump_sfx: AudioStreamPlayer
var land_sfx: AudioStreamPlayer
var ui_sfx: AudioStreamPlayer
var step_cooldown: float = 0.0
const STEP_INTERVAL: float = 0.42

func _ready() -> void:
	step_sfx = _make_player("StepSFX", "489946__falcospizaetus__slowstepsonrock03.wav")
	jump_sfx = _make_player("JumpSFX", "464607__d001447733__jump_end_gravel.wav")
	land_sfx = _make_player("LandSFX", "404394__eskimoneil__jump-thump.wav")
	ui_sfx = _make_player("UISFX", "628638__el_boss__menu-select-tick.wav")

	var player: CharacterBody3D = get_node_or_null("/root/TestArena/Player")
	if player:
		player.stepping.connect(_on_step)
		player.jumped.connect(_on_jump)
		player.landed.connect(_on_land)

func _make_player(p_name: String, file: String) -> AudioStreamPlayer:
	var p := AudioStreamPlayer.new()
	p.name = p_name
	p.bus = "Master"
	var path := "res://assets/sounds/" + file
	if ResourceLoader.exists(path):
		var stream: AudioStream = load(path)
		if stream:
			p.stream = stream
	add_child(p)
	return p

func _on_step() -> void:
	if step_cooldown > 0:
		return
	step_cooldown = STEP_INTERVAL
	_safe_play(step_sfx)

func _on_jump() -> void:
	_safe_play(jump_sfx)

func _on_land() -> void:
	_safe_play(land_sfx)

func _safe_play(player: AudioStreamPlayer) -> void:
	if player and player.stream:
		player.pitch_scale = randf_range(0.85, 1.15)
		player.play()

func _process(delta: float) -> void:
	if step_cooldown > 0:
		step_cooldown -= delta
