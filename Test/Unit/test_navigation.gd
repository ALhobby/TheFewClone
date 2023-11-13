extends "res://addons/gut/test.gd"

var nav_system = load("res://Navigation.gd")
var _nav_sys = null


func before_each():
	"""Called before each test. Ensures we create a clean instance of the object we are testing.
	"""
	_nav_sys = nav_system.new()


func after_each():
	_nav_sys.free()


####################################################################################################
# Tests
####################################################################################################
#func test_create_new_marker():
#	var marker = _nav_sys.create_new_marker()
#	assert_not_null(marker, "Expecting non null marker")


func test_get_held_status():
	var result = _nav_sys.get_held_status()
	assert_eq(result, false, "Expecting 'false'")
