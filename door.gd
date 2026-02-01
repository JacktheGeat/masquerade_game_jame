class_name DOOR
extends Area2D

@export var requiredItems :Array[String]
@export var itemQuantities: Array[int]

var isLocked = true

func unlock(getInventory: Callable):
	if isLocked:
		isLocked = false
		for index in range(len(requiredItems)):
			if getInventory.call(requiredItems[index]) < itemQuantities[index]:
				isLocked = true
	return isLocked
