extends CharacterBody2D

const GROUND_SPEED = 100
const jump_velocity = -565
const air_speed = 280
var mass = -100
var time = 0
var jump_percentage = 0
var skip = false
@onready var jumper_sprite: AnimatedSprite2D = $jumper_sprite
var bounce_back = 0
var velo_x = 0
@onready var collision_shape_2d_5: CollisionShape2D = $CollisionShape2D5

func _physics_process(delta) -> void:
	if is_on_ceiling():
		time = 0
	if is_on_floor():
		velocity.x = 0
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction and not Input.is_action_pressed("ui_accept"):
			if direction < 0:
				jumper_sprite.animation = "run"
				jumper_sprite.flip_h = true
			else: 
				jumper_sprite.animation = "run"
				jumper_sprite.flip_h = false
			velocity.x = direction * GROUND_SPEED
		else:
			jumper_sprite.animation = "idle"
			velocity.x = move_toward(velocity.x, 0, GROUND_SPEED)
	else:
		jumper_sprite.animation = "flying"
		velocity += get_gravity() * delta
		
	# Handle jump.
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		jumper_sprite.animation = "load"
		time += 0.02
		if time > 1:
			var direction := Input.get_axis("ui_left", "ui_right")
			bounce_back = direction
			if direction < 0:
				jumper_sprite.flip_h = true
			else: 
				jumper_sprite.flip_h = false
			jump_percentage = time
			velocity.y = jump_percentage * jump_velocity
			skip = true
			if direction:
				velocity.x = direction * air_speed
				time = 0
		else: 
			skip = false
	if Input.is_action_just_released("ui_accept"):
		jump_percentage = time
		time = 0
		if not skip and jump_percentage >= 0.20:
			var direction := Input.get_axis("ui_left", "ui_right")
			bounce_back = direction
			if direction < 0:
				jumper_sprite.flip_h = true
			else: 
				jumper_sprite.flip_h = false
			velocity.y = jump_percentage * jump_velocity
			if direction:
				velocity.x = direction * air_speed
	var wall_normal = Vector2(0, 0)
	wall_normal = get_wall_normal()
	if wall_normal[0] == -1 or wall_normal[0] == 1:
		if is_on_wall_only() and not position.x >= 244 and not position.x <= -246:
			if bounce_back > 0:
				velocity.x = -150
				bounce_back = -1
			else:
				velocity.x = 150
				bounce_back = 1
		
	#collider_tester
	#if Input.is_action_pressed("ui_down"):
		#var direction := Input.get_axis("ui_left", "ui_right")
		#if direction:
				#velocity.x = direction * air_speed
		#velocity.y = -300
	move_and_slide()
	
