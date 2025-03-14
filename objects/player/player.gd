extends CharacterBody3D

@export_range(1, 35, 1) var speed: float = 10 # m/s
@export_range(10, 400, 1) var acceleration: float = 100 # m/s^2

@export_range(0.1, 3.0, 0.1) var jump_height: float = 2 # m
@export_range(0.1, 3.0, 0.1, "or_greater") var camera_sens: float = 1

var jumping: bool = false
var mouse_captured: bool = false

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var move_dir: Vector2 # Input direction for movement
var look_dir: Vector2 # Input direction for look/aim

var walk_vel: Vector3 # Walking velocity 
var grav_vel: Vector3 # Gravity velocity 
var jump_vel: Vector3 # Jumping velocity

@onready var camera: Camera3D = $Camera

var fast_rotate_state = false
@export var fast_rotate_speed = 8
var current_rotation = 0.0
var last_angle = 0.0
var target_rotation = 0.0

var raysep = 6
var rayamount = Vector2(3,3)

func _ready() -> void:
	capture_mouse()
	
func _process(delta: float) -> void:
	sundetection()
	if Global.activepowerups["megashot"] == true:
		raysep = 24
		rayamount = Vector2(5,5)
	else:
		raysep = 6
		rayamount = Vector2(3,3)
	if Input.is_action_just_pressed("shoot"):
		$shoot.play()


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		print

func _physics_process(delta: float) -> void:

	if Input.is_key_pressed(KEY_SPACE): jumping = true

	if mouse_captured: _handle_joypad_camera_rotation(delta)
	velocity = _walk(delta) + _gravity(delta) + _jump(delta)
	
	_rotate_camera(delta)
	move_and_slide()

func capture_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	mouse_captured = true

func release_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false

func _rotate_camera(delta) -> void:
	if Input.is_action_just_pressed("rotate_180"):
		fast_rotate_state = true
		current_rotation = Global.camrot
	if fast_rotate_state:
		if current_rotation > last_angle: 
			rotation_side(1, delta)
		else:
			rotation_side(-1, delta)
	else:
		last_angle = Global.camrot		
				
	$SubViewport/Camera2.rotation_degrees = camera.rotation_degrees - Vector3(-10,180,0)
	$SubViewport/Camera2.position = $Camera.global_position + $Camera.transform.basis.z * 0.5

	Global.camrot -= Input.get_axis("rotate_left", "rotate_right") * camera_sens * delta
	camera.rotation.y = Global.camrot
	
	#camera.rotation.x = clamp(camera.rotation.x - look_dir.y * camera_sens * sens_mod, -1.5, 1.5)
		
func rotation_side(side, delta):
	target_rotation = current_rotation + deg_to_rad(180) * side
	Global.camrot = lerpf(Global.camrot, target_rotation + deg_to_rad(10) * side, delta * fast_rotate_speed)
	if Global.camrot * side >= target_rotation * side:
		Global.camrot = target_rotation
		fast_rotate_state = false


func _handle_joypad_camera_rotation(delta: float, sens_mod: float = 1.0) -> void:
	return
	var joypad_dir: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if joypad_dir.length() > 0:
		look_dir += joypad_dir * delta
		_rotate_camera(sens_mod)
		look_dir = Vector2.ZERO

func _walk(delta: float) -> Vector3:
	return Vector3(0,0,0)
	move_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var _forward: Vector3 = camera.global_transform.basis * Vector3(move_dir.x, 0, move_dir.y)
	var walk_dir: Vector3 = Vector3(_forward.x, 0, _forward.z).normalized()
	walk_vel = walk_vel.move_toward(walk_dir * speed * move_dir.length(), acceleration * delta)
	
	return walk_vel

func _gravity(delta: float) -> Vector3:
	grav_vel = Vector3.ZERO if is_on_floor() else grav_vel.move_toward(Vector3(0, velocity.y - gravity, 0), gravity * delta)
	return grav_vel

func _jump(delta: float) -> Vector3:
	return Vector3(0,0,0)
	if jumping:
		if is_on_floor(): jump_vel = Vector3(0, sqrt(4 * jump_height * gravity), 0)
		jumping = false
		return jump_vel
	jump_vel = Vector3.ZERO if is_on_floor() or is_on_ceiling_only() else jump_vel.move_toward(Vector3.ZERO, gravity * delta)
	return jump_vel

func sundetection():

	# i * raysep - raysep*rayamount.x/2.0
	# -(rayamount.x-1)*raysep/2 + i*raysep
	
	# raycasting sam nie wiem co tu sie dzieje xd
	# ale dziala
	var count = 0
	for i in range(rayamount.x):
		for j in range(rayamount.y):
			const RAY_LENGTH = 500000

			var space_state = get_world_3d().direct_space_state
			var cam = $Camera
			var mousepos = get_viewport().get_mouse_position()
			
			Global.mousepos = mousepos
			var origin = cam.project_ray_origin(mousepos + Vector2(-(rayamount.x-1)*raysep/2 + i*raysep,-(rayamount.y-1)*raysep/2 + j*raysep))

			var end = origin + cam.project_ray_normal(mousepos  + Vector2(-(rayamount.x-1)*raysep/2 + i*raysep,-(rayamount.y-1)*raysep/2 + j*raysep)) * RAY_LENGTH
			var query = PhysicsRayQueryParameters3D.create(origin, end, 1)
			query.collide_with_areas = true
			
			var result = space_state.intersect_ray(query)
			if result.has("collider"):
				var laser = false
				if Global.activepowerups["laser"] == true:
					laser = true
				
				if (result["collider"].get_class()) == "Area3D":
					if (get_node(result["collider"].get_path()).is_in_group("enemy")):
						get_node(result["collider"].get_path()).oncursor[0] = true
						if Input.is_action_just_pressed("shoot"):
							get_parent().deleteEnemy(result["collider"])
							return
						if laser == true:
							get_parent().deleteEnemy(result["collider"])
					if (get_node(result["collider"].get_path()).is_in_group("bullet")):
						if Input.is_action_just_pressed("shoot"):
							get_parent().deleteBullet(result["collider"])
							print("eh")
						if laser == true:
							get_parent().deleteBullet(result["collider"])
					if (get_node(result["collider"].get_path()).is_in_group("powerup")):
						if Input.is_action_just_pressed("shoot"):
							var node = get_node(result["collider"].get_path())
							if node.ded == false:
								Global.powerups.append(node.data[node.type])
							node.ded = true
							
							get_node(result["collider"].get_path()).queue_free()
							

#func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventMouseMotion:
	#	look_dir = event.relative * 0.001
		#if mouse_captured: _rotate_camera()
