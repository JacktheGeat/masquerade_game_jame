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

@export var giftGiving : String
@export var quantityGiven : int = 1

@export var giftWanted : String
@export var quantityWanted : int = 1

var spokenYet := false
var doneWithYou := false



func interact(playerInventory :Dictionary) -> DialogBox: #return the correct dialog
	var newDialog = BoxBase.instantiate()

	if not spokenYet:
		spokenYet = true

		newDialog.assemble(myPicture, dialog_initial)

	elif doneWithYou: # if player inventory contains needed item
		newDialog.assemble(myPicture, dialog_doneWithYou)

	elif giftWanted == '': # recieving gift no conditions
		playerInventory.set(giftGiving, playerInventory.get(giftGiving, 0)+1)

		doneWithYou = true

		dialog_onGiftRecieved.append("You recieved a %s" % giftGiving)
		newDialog.assemble(myPicture, dialog_onGiftRecieved)

	elif playerInventory.get(giftWanted) and playerInventory[giftWanted] > 0: #recieving gift with conditions
		playerInventory[giftWanted] -= 1
		playerInventory.set(giftGiving, playerInventory.get(giftGiving, 0)+1)

		doneWithYou = true

		dialog_onGiftRecieved.append("You recieved a [%s]" % giftGiving)
		newDialog.assemble(myPicture, dialog_onGiftRecieved)

	else: # waiting for gift
		newDialog.assemble(myPicture, dialog_stillWaiting)

	return newDialog
