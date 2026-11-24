class_name BagRandomizer
extends Node
#This simulates a "bag of coloured marbles situation," where we input things and take them out randomly
#While keeping the correcct probabilites

var _entries_and_occurences: Dictionary[Variant, int] = {}

func put(entry, occurences: int):
	if !_entries_and_occurences.has(entry):
		_entries_and_occurences[entry] = 0
	
	_entries_and_occurences[entry] += occurences

func grab() -> Variant:
	var entries = _entries_and_occurences.keys()
	
	var sum = 0
	var entries_and_up_bounds = {}

	for entry in entries:
		sum += _entries_and_occurences[entry]
		entries_and_up_bounds[entry] = sum
	
	#We shift the random number by 1, thus getting us into range (1,..., sum)
	var order = (randi() % sum) + 1
	var last_bound = 0
	for entry in entries:
		if last_bound < order and order <= entries_and_up_bounds[entry]:
			_entries_and_occurences[entry] -= 1
			if _entries_and_occurences[entry] == 0:
				_entries_and_occurences.erase(entry)
			return entry
			
		last_bound = entries_and_up_bounds[entry]
	
	push_error("Bag randomizer got out of bounds")
	return null

func is_empty():
	return _entries_and_occurences.is_empty()
