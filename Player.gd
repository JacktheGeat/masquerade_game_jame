extends CharacterBody2D


const SPEED = 300.0

const roomXMIN = 0
const roomXMAX = 1152
const roomYMIN = 0
const roomYMAX = 648


func _physics_process(delta: float) -> void:


	var playerWidth = $PlayerSprite.get_rect().size.x * $PlayerSprite.scale.x /2
	var playerHeight = $PlayerSprite.get_rect().size.y * $PlayerSprite.scale.y /2
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_pressed("ui_left") and position.x > roomXMIN + playerWidth:
		velocity.x = -1 * SPEED
	elif Input.is_action_pressed("ui_right") and position.x < roomXMAX - playerWidth:
		velocity.x = 1 * SPEED
	else: velocity.x = 0
	if Input.is_action_pressed("ui_up") and position.y > roomYMIN + playerHeight:
		velocity.y = -1 * SPEED
	elif Input.is_action_pressed("ui_down") and position.y < roomYMAX - playerWidth:
		velocity.y = 1 * SPEED
	else: velocity.y = 0

	move_and_slide()
