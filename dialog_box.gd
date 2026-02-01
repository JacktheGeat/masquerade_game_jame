class_name DialogBox
extends CanvasLayer

## documentation here

@export var something :String

var speechStrings :Array[String]

var currentPage: int = 0;

func assemble(npcPicture, npcDialog, finalGift=null):
	# install npc picture where it goes
	# display first speech string
	speechStrings = npcDialog
	$HBoxContainer/VBoxContainer/Panel/portrait.texture = npcPicture
	$HBoxContainer/SpeechBox.text = '\n'.join(speechStrings[currentPage].split('\\n'))


	#print('\n'.join(speechStrings[currentPage].split('\\n')))
	# if final gift is present, add "you got [item]" sting to end
	pass

func nextPage():
	if currentPage == len(speechStrings)-1:
		self.queue_free()
		return false
	currentPage += 1
	$HBoxContainer/SpeechBox.clear()
	$HBoxContainer/SpeechBox.append_text('\n'.join(speechStrings[currentPage].split('\\n')))
	return true
