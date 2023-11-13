extends "res://addons/gut/test.gd"


func test_some_method():
	assert_eq("A", "B", "Expecting 'B'")
