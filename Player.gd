extends CharacterBody2D


const SPEED = 300.0

const roomXMIN = 0
const roomXMAX = 1152
const roomYMIN = 0
const roomYMAX = 648

var isDialogueListening: bool = false
var currentDialogue: DialogBox = null

var playerInventory := { 'cotton': false,
						'ribbon': false,
						'paint': false,
						}



func _physics_process(delta: float) -> void:
	var playerWidth = $PlayerSprite.get_rect().size.x * $PlayerSprite.scale.x /2
	var playerHeight = $PlayerSprite.get_rect().size.y * $PlayerSprite.scale.y /2

	if not isDialogueListening:
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

	if Input.is_action_just_pressed("ui_accept"):
		check_for_player()


func check_for_player():
	if isDialogueListening: # are you listening to dialogue?
		isDialogueListening = currentDialogue.nextPage()
		if not isDialogueListening: #is there no dialogue being shown? delete!
			currentDialogue = null
		return
	# check if there are any objects in the area!
	var area2ds = $NPC_detector.get_overlapping_areas()
	for obj: Area2D in area2ds:
		if is_instance_of(obj, NPC): # is it an NPC?
			if obj.has_method("interact"): # do they have an interaction?
				print("interact!")
				currentDialogue = obj.interact(playerInventory)
				isDialogueListening = true
				$Inventory_Layer.add_child(currentDialogue)
