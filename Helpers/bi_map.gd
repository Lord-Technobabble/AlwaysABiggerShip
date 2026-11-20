class_name BiMap
extends RefCounted

#Not very safe for now, but it will do
var _a_to_b: Dictionary[Variant, Variant] = {}
var _b_to_a: Dictionary[Variant, Variant] = {}

func assign(a: Variant, b: Variant):
	_a_to_b[a] = b
	_b_to_a[b] = a

func get_a(b: Variant):
	return _b_to_a[b]

func get_b(a: Variant):
	return _a_to_b[a]

func erase_a(a: Variant):
	var b = _a_to_b[a]
	_a_to_b.erase(a)
	_b_to_a.erase(b)

func erase_b(b: Variant):
	var a = _b_to_a[b]
	erase_a(a)

func has_a(a: Variant):
	return _a_to_b.has(a)

func has_b(b: Variant):
	return _b_to_a.has(b)
