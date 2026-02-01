class_name NPC
extends Node

## thing they want:
## thing they give:

var BoxBase = preload('res://dialog_box.tscn')


@export var myPicture :Texture2D
@export var dialog_initial :Array[String]
@export var dialog_onGiftRecieved :Array[String]
@export var dialog_doneWithYou :Array[String]
@export var dialog_stillWaiting :Array[String]

@export var giftName :String

var spokenYet := false
var doneWithYou := false



func interact(playerInventory :Dictionary) -> DialogBox: #return the correct dialog
	var newDialog = BoxBase.instantiate()

	if not spokenYet:
		spokenYet = true

		newDialog.assemble(myPicture, dialog_initial)

	elif doneWithYou: # if player inventory contains needed item
		newDialog.assemble(myPicture, dialog_doneWithYou)

	elif giftName == '':
		playerInventory.set('Red Rose', 1)
		doneWithYou = true
		newDialog.assemble(myPicture, dialog_onGiftRecieved)

		
	elif playerInventory.get(giftName) and playerInventory[giftName] > 0: #recieving gift
		playerInventory[giftName] -= 1
		doneWithYou = true
		newDialog.assemble(myPicture, dialog_onGiftRecieved)

	else: # waiting for gift
		newDialog.assemble(myPicture, dialog_stillWaiting)
	
	return newDialog
