class_name NPC
extends Node

## thing they want:
## thing they give:

var BoxBase :PackedScene = preload('res://dialog_box.tscn')

@export var myPicture :Texture2D

@export var dialog_initial :Array[String]
@export var dialog_onGiftRecieved :Array[String]
@export var dialog_doneWithYou :Array[String]

@export var giftName :String
@export var giftIcon :Texture2D

var doneWithYou := false



func interact(playerInventory) -> DialogBox: #return the correct dialog

	var newDialog = BoxBase.instantiate()
	newDialog

	if doneWithYou:
		pass
	elif (false): # if player inventory contains needed item
		pass
	else:
		pass

	return newDialog
