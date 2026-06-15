extends CanvasLayer

enum MapMode { VIEW_FOLLOW, LOCKED }
enum Corner { TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT }

const MAP_SIZE: float = 170.0
const WORLD_RANGE: float = 60.0
const CARDINAL_COLORS := { "N": Color.RED, "S": Color.WHITE, "E": Color.WHITE, "W": Color.WHITE }
const CORNER_LABELS := ["左上", "右上", "左下", "右下"]

var map_mode: int = MapMode.LOCKED
var current_corner: int = Corner.TOP_RIGHT

var player: CharacterBody3D
var world_bodies: Array[Node3D] = []

var map_panel: Panel
var map_draw: Control
var mode_btn: Button
var corner_btns: Array[Button] = []

func _ready() -> void:
	player = get_node_or_null("/root/TestArena/Player")
	if not player:
		var nodes = get_tree().get_nodes_in_group("player")
		if nodes.size() > 0:
			player = nodes[0]

	_scan_world()
	_build_ui()
	_apply_corner()

func _scan_world() -> void:
	var root := get_node_or_null("/root/TestArena")
	if not root:
		return
	for child in root.get_children():
		if child is StaticBody3D:
			world_bodies.append(child)

func _build_ui() -> void:
	# Outer container
	var container := Control.new()
	container.name = "MinimapContainer"
	container.custom_minimum_size = Vector2(MAP_SIZE + 12, MAP_SIZE + 50)
	add_child(container)

	# Circular map panel
	map_panel = Panel.new()
	map_panel.name = "MapPanel"
	map_panel.size = Vector2(MAP_SIZE, MAP_SIZE)
	map_panel.position = Vector2(6, 6)
	var panel_style := StyleBoxFlat.new()
	panel_style.bg_color = Color(0.05, 0.05, 0.08, 0.85)
	panel_style.border_width_left = 2
	panel_style.border_width_right = 2
	panel_style.border_width_top = 2
	panel_style.border_width_bottom = 2
	panel_style.border_color = Color(0.4, 0.4, 0.45)
	panel_style.corner_radius_top_left = int(MAP_SIZE / 2)
	panel_style.corner_radius_top_right = int(MAP_SIZE / 2)
	panel_style.corner_radius_bottom_left = int(MAP_SIZE / 2)
	panel_style.corner_radius_bottom_right = int(MAP_SIZE / 2)
	map_panel.add_theme_stylebox_override("panel", panel_style)
	container.add_child(map_panel)

	# Draw layer on top of panel
	map_draw = Control.new()
	map_draw.name = "MapDraw"
	map_draw.size = Vector2(MAP_SIZE, MAP_SIZE)
	map_draw.position = Vector2(6, 6)
	map_draw.mouse_filter = Control.MOUSE_FILTER_IGNORE
	map_draw.draw.connect(_on_draw)
	map_panel.add_child(map_draw)

	# Mode toggle button
	mode_btn = Button.new()
	mode_btn.name = "ModeBtn"
	mode_btn.text = "锁定 (N)"
	mode_btn.position = Vector2(6, MAP_SIZE + 10)
	mode_btn.custom_minimum_size = Vector2(MAP_SIZE, 24)
	mode_btn.pressed.connect(_on_mode_toggle)
	container.add_child(mode_btn)

	# Corner selector (2x2 grid of small buttons)
	var corner_grid := Control.new()
	corner_grid.name = "CornerGrid"
	corner_grid.position = Vector2(0, MAP_SIZE + 38)
	corner_grid.custom_minimum_size = Vector2(MAP_SIZE + 12, 30)
	container.add_child(corner_grid)

	var btn_size := Vector2(26, 20)
	var grid_w := MAP_SIZE + 12
	var positions := [
		Vector2(0, 0),                    # TL
		Vector2(grid_w - 26, 0),          # TR
		Vector2(0, 0),                    # placeholder, will set below
		Vector2(grid_w - 26, 0)           # placeholder, will set below
	]
	# Second row (actual BL, BR)
	positions[2] = Vector2(0, 22)
	positions[3] = Vector2(grid_w - 26, 22)

	var labels := ["↖", "↗", "↙", "↘"]
	for i in range(4):
		var btn := Button.new()
		btn.name = "CornerBtn%d" % i
		btn.text = labels[i]
		btn.position = positions[i]
		btn.size = btn_size
		btn.pressed.connect(_on_corner_changed.bind(i))
		corner_grid.add_child(btn)
		corner_btns.append(btn)

func _apply_corner() -> void:
	var container := get_node_or_null("MinimapContainer")
	if not container:
		return

	var viewport_size := get_viewport().get_visible_rect().size
	var margin := 10.0

	match current_corner:
		Corner.TOP_LEFT:
			container.position = Vector2(margin, margin)
		Corner.TOP_RIGHT:
			container.position = Vector2(viewport_size.x - MAP_SIZE - 12 - margin, margin)
		Corner.BOTTOM_LEFT:
			container.position = Vector2(margin, viewport_size.y - MAP_SIZE - 50 - margin)
		Corner.BOTTOM_RIGHT:
			container.position = Vector2(viewport_size.x - MAP_SIZE - 12 - margin, viewport_size.y - MAP_SIZE - 50 - margin)

func _on_mode_toggle() -> void:
	map_mode = MapMode.VIEW_FOLLOW if map_mode == MapMode.LOCKED else MapMode.LOCKED
	mode_btn.text = "跟随 (N)" if map_mode == MapMode.VIEW_FOLLOW else "锁定 (N)"

func _on_corner_changed(idx: int) -> void:
	current_corner = idx as Corner
	_apply_corner()

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_N:
			_on_mode_toggle()
			get_viewport().set_input_as_handled()

func _process(_delta: float) -> void:
	map_draw.queue_redraw()

func _on_draw() -> void:
	if not player:
		return

	var center := map_draw.size / 2.0
	var radius := MAP_SIZE / 2.0 - 3.0
	var scale := radius / WORLD_RANGE
	var player_yaw: float = player.rotation.y

	# Background
	map_draw.draw_circle(center, radius, Color(0.1, 0.12, 0.15, 0.6))

	# Draw world objects
	for body in world_bodies:
		var obj_pos := body.global_position
		var obj_size := _get_body_size(body)
		var rel := obj_pos - player.global_position

		# Apply mode transform
		var map_pos: Vector2
		if map_mode == MapMode.LOCKED:
			map_pos = center + Vector2(rel.x * scale, -rel.z * scale)
		else:
			var rotated := Vector2(rel.x, rel.z).rotated(-player_yaw)
			map_pos = center + Vector2(rotated.x * scale, -rotated.y * scale)

		# Skip if off map
		if map_pos.distance_to(center) > radius + 10:
			continue

		var obj_w := maxf(obj_size.x * scale, 2.0)
		var obj_h := maxf(obj_size.z * scale, 2.0)
		var rect := Rect2(map_pos - Vector2(obj_w, obj_h) / 2.0, Vector2(obj_w, obj_h))
		map_draw.draw_rect(rect, Color(0.6, 0.55, 0.5, 0.8))

	# Player marker — triangle
	var player_map_pos: Vector2
	var player_dir_angle: float

	if map_mode == MapMode.LOCKED:
		player_map_pos = center + Vector2(0, 0)
		player_dir_angle = -player_yaw - PI / 2.0  # Convert Godot rotation to map: forward = -Z = "up"
	else:
		player_map_pos = center
		player_dir_angle = -PI / 2.0  # Always point up

	var tri_size := 7.0
	var tip := player_map_pos + Vector2(cos(player_dir_angle), sin(player_dir_angle)) * tri_size
	var left := player_map_pos + Vector2(cos(player_dir_angle + 2.4), sin(player_dir_angle + 2.4)) * tri_size * 0.55
	var right := player_map_pos + Vector2(cos(player_dir_angle - 2.4), sin(player_dir_angle - 2.4)) * tri_size * 0.55
	var tri_points := PackedVector2Array([tip, left, right])
	map_draw.draw_polygon(tri_points, PackedColorArray([Color.CYAN]))

	# Cardinal direction labels
	var font := ThemeDB.fallback_font
	if not font:
		return

	var dirs: Dictionary = {
		"N": Vector2(0, -1),
		"S": Vector2(0, 1),
		"E": Vector2(1, 0),
		"W": Vector2(-1, 0)
	}
	for dir_name: String in dirs:
		var base: Vector2 = dirs[dir_name]
		var label_dir: Vector2 = base
		if map_mode == MapMode.VIEW_FOLLOW:
			label_dir = base.rotated(-player_yaw)

		var label_pos: Vector2 = center + label_dir * (radius - 14)
		var col: Color = Color.RED if dir_name == "N" else Color(0.85, 0.85, 0.85)
		map_draw.draw_string(font, label_pos - Vector2(7, 5), dir_name, HORIZONTAL_ALIGNMENT_CENTER, -1, 14, col)

	# Thin border ring
	map_draw.draw_arc(center, radius, 0, TAU, 64, Color(0.5, 0.5, 0.55), 1.5)

func _get_body_size(body: Node3D) -> Vector3:
	var col := body.get_node_or_null("CollisionShape3D")
	if col and col.shape is BoxShape3D:
		return (col.shape as BoxShape3D).size
	return Vector3(1, 1, 1)
