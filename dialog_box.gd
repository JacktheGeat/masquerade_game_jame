class_name DialogBox
extends Control

## documentation here

var speechStrings :Array[String]

func assemble(npcPicture, npcDialog, finalGift=null):
	# install npc picture where it goes
	# display first speech string

	# if final gift is present, add "you got [item]" sting to end
	pass

func nextPage():
	# if remaining pages, show next and return Wait indicator; else, return final gift or Done indicator
	pass
