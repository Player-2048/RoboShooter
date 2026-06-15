extends CanvasLayer

@onready var mech_bar = _safe_node("MechBar") as TextureProgressBar
@onready var signal_bar = _safe_node("SignalBar") as TextureProgressBar
@onready var energy_bar = _safe_node("EnergyBar") as TextureProgressBar
@onready var health_label = _safe_node("HealthLabel") as Label
@onready var signal_label = _safe_node("SignalLabel") as Label
@onready var crosshair_rect = _safe_node("Crosshair") as TextureRect
@onready var health_text = _safe_node("Health") as Label

var player: CharacterBody3D

func _safe_node(path: String) -> Node:
	return get_node_or_null(path)

func _ready() -> void:
	player = get_node_or_null("/root/Main/Player")
	if not player:
		return
	if player.has_signal("health_updated") and not player.health_updated.is_connected(_on_health_updated):
		player.health_updated.connect(_on_health_updated)
	if player.has_signal("signal_updated") and not player.signal_updated.is_connected(_on_signal_updated):
		player.signal_updated.connect(_on_signal_updated)
	if player.has_signal("energy_updated") and not player.energy_updated.is_connected(_on_energy_updated):
		player.energy_updated.connect(_on_energy_updated)

func _on_health_updated(health_val: int) -> void:
	if health_text:
		health_text.text = str(health_val) + "%"
	if mech_bar:
		mech_bar.value = health_val
	if health_label:
		health_label.text = "MECH " + str(health_val) + "%"

func _on_signal_updated(signal_val: int) -> void:
	if signal_bar:
		signal_bar.value = signal_val
		var t: float = signal_val / 100.0
		signal_bar.tint_progress = Color(1.0 - t, t, 0.0)
	if signal_label:
		signal_label.text = "SIG " + str(signal_val) + "%"

func _on_energy_updated(energy_val: int) -> void:
	if energy_bar:
		energy_bar.value = energy_val

func _process(_delta: float) -> void:
	if not player or not crosshair_rect:
		return
	var vp_size := get_viewport().get_visible_rect().size
	crosshair_rect.position = vp_size / 2.0 - crosshair_rect.size / 2.0
