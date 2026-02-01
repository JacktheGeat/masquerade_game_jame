class_name NPC
extends Node

## thing they want:
## thing they give:

var BoxBase = preload('res://dialog_box.tscn')

@export var npcName :String
@export var myPicture :Texture2D
@export var dialog_initial :Array[String]
@export var dialog_onGiftRecieved :Array[String]
@export var dialog_doneWithYou :Array[String]
@export var dialog_stillWaiting :Array[String]

@export var giftGiving : Array[String]
@export var quantityGiven : Array[int] = []

@export var giftWanted : Array[String]
@export var quantityWanted : Array[int] = []

var spokenYet := false
var doneWithYou := false



func interact(getInventory: Callable, addInventory: Callable) -> DialogBox: #return the correct dialog
	var newDialog = BoxBase.instantiate()

	if not spokenYet:
		spokenYet = true

		newDialog.assemble(myPicture, dialog_initial)

	elif doneWithYou: # if player inventory contains needed item
		newDialog.assemble(myPicture, dialog_doneWithYou)

	elif giftWanted == [] and giftGiving != []: # recieving gift no conditions
		for index in range(len(giftGiving)):
			addInventory.call(giftGiving[index], 1)
		#playerInventory.set(giftGiving, playerInventory.get(giftGiving, 0)+1)
			doneWithYou = true
			dialog_onGiftRecieved.append("You recieved a %s" % giftGiving[index])
		newDialog.assemble(myPicture, dialog_onGiftRecieved)

	else: # waiting for gift
		var conditionsMet = true
		for index in range(len(giftWanted)):
			print("there are %s %s in inventory" % [getInventory.call(giftWanted[index]),giftWanted[index]])
			print()
			if getInventory.call(giftWanted[index]) < quantityWanted[index]: #recieving gift with conditions
				conditionsMet = false
		if (conditionsMet):
			var toReturn = ""
			for index in range(len(giftWanted)):
				addInventory.call(giftWanted[index], -1 * quantityWanted[index])
				addInventory.call(giftGiving[index], quantityGiven[index])
				doneWithYou = true
				toReturn += "You recieved a [%s]\n" % giftGiving[index]
			dialog_onGiftRecieved.append(toReturn)
			newDialog.assemble(myPicture, dialog_onGiftRecieved)

		newDialog.assemble(myPicture, dialog_stillWaiting)

	return newDialog
