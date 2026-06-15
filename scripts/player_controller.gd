extends CharacterBody3D

signal jumped
signal landed
signal stepping

@export var move_speed: float = 6.0
@export var sprint_multiplier: float = 1.6
@export var jump_velocity: float = 5.0
@export var mouse_sensitivity: float = 0.002
@export var acceleration: float = 12.0

@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var desired_velocity: Vector3 = Vector3.ZERO
var arm_block: MeshInstance3D
var bob_time: float = 0.0
var was_on_floor: bool = true

func _ready() -> void:
	add_to_group("player")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_create_arm_block()
	_create_crosshair()

func _create_arm_block() -> void:
	arm_block = MeshInstance3D.new()
	arm_block.name = "ArmBlock"
	var box := BoxMesh.new()
	box.size = Vector3(0.12, 0.12, 0.35)
	arm_block.mesh = box
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(0.55, 0.45, 0.35)
	arm_block.material_override = mat
	arm_block.position = Vector3(0.32, -0.22, -0.5)
	arm_block.rotation_degrees = Vector3(-12, -8, 4)
	camera.add_child(arm_block)

func _create_crosshair() -> void:
	var ch := Control.new()
	ch.name = "Crosshair"
	ch.mouse_filter = Control.MOUSE_FILTER_IGNORE
	ch.draw.connect(_draw_crosshair.bind(ch))
	ch.set_anchors_preset(Control.PRESET_FULL_RECT)
	camera.add_child(ch)

func _draw_crosshair(ch: Control) -> void:
	var c := ch.size / 2.0
	var gap := 6.0
	var len := 8.0
	var thick := 2.0
	var col := Color(1, 1, 1, 0.85)
	# Vertical
	ch.draw_rect(Rect2(c.x - thick / 2.0, c.y - len - gap, thick, len), col)
	ch.draw_rect(Rect2(c.x - thick / 2.0, c.y + gap, thick, len), col)
	# Horizontal
	ch.draw_rect(Rect2(c.x - len - gap, c.y - thick / 2.0, len, thick), col)
	ch.draw_rect(Rect2(c.x + gap, c.y - thick / 2.0, len, thick), col)
	# Center dot
	ch.draw_rect(Rect2(c.x - 0.5, c.y - 0.5, 1, 1), col)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		head.rotate_x(-event.relative.y * mouse_sensitivity)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))

	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
		jumped.emit()

	if is_on_floor() and not was_on_floor:
		landed.emit()

	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	var speed := move_speed
	if Input.is_action_pressed("sprint"):
		speed *= sprint_multiplier

	desired_velocity = direction * speed
	velocity.x = move_toward(velocity.x, desired_velocity.x, acceleration * delta)
	velocity.z = move_toward(velocity.z, desired_velocity.z, acceleration * delta)

	if is_on_floor() and direction.length() > 0.1:
		stepping.emit()

	move_and_slide()
	_update_arm_bob(delta, direction.length())
	was_on_floor = is_on_floor()

func _update_arm_bob(delta: float, moving: float) -> void:
	if is_on_floor() and moving > 0.1:
		bob_time += delta * 9.0
	else:
		bob_time = move_toward(bob_time, 0.0, delta * 6.0)

	var bob_y := sin(bob_time * 2.0) * 0.02
	var bob_x := sin(bob_time) * 0.012
	arm_block.position = Vector3(0.32 + bob_x, -0.22 + bob_y, -0.5)
