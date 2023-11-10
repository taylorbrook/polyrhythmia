extends Node

#delay lines (tap1, tap2, feedback) for the player busses
@export var delaytap_player_left1 = 0.0 : set = _delaytap_player_left1_setter, get = _delaytap_player_left1_getter
@export var delaytap_player_left2 = 0.0 : set = _delaytap_player_left2_setter, get = _delaytap_player_left2_getter
@export var feedback_player_left = 0.0 : set = _feedback_player_left_setter, get = _feedback_player_left_getter
@export var delaytap_player_right1 = 0.0 : set = _delaytap_player_right1_setter, get = _delaytap_player_right1_getter
@export var delaytap_player_right2 = 0.0 : set = _delaytap_player_right2_setter, get = _delaytap_player_right2_getter
@export var feedback_player_right = 0.0 : set = _feedback_player_right_setter, get = _feedback_player_right_getter

#delay lines for the backing track
@export var delaytap_backing_left1 = 0.0 : set = _delaytap_backing_left1_setter, get = _delaytap_backing_left1_getter
@export var delaytap_backing_left2 = 0.0 : set = _delaytap_backing_left2_setter, get = _delaytap_backing_left2_getter
@export var feedback_backing_left = 0.0 : set = _feedback_backing_left_setter, get = _feedback_backing_left_getter
@export var delaytap_backing_right1 = 0.0 : set = _delaytap_backing_right1_setter, get = _delaytap_backing_right1_getter
@export var delaytap_backing_right2 = 0.0 : set = _delaytap_backing_right2_setter, get = _delaytap_backing_right2_getter
@export var feedback_backing_right = 0.0 : set = _feedback_backing_right_setter, get = _feedback_backing_right_getter

func _ready():
	_delaytap_player_left1_getter()
	_delaytap_player_left2_getter()
	_feedback_player_left_getter()
	_delaytap_player_right1_getter()
	_delaytap_player_right2_getter()
	_feedback_player_right_getter()
	_delaytap_backing_left1_getter()
	_delaytap_backing_left2_getter()
	_feedback_backing_left_getter()
	_delaytap_backing_right1_getter()
	_delaytap_backing_right2_getter()
	_feedback_backing_right_getter()

#delay times for player_left bus, setting and getting the values
func _delaytap_player_left1_setter(val):
	delaytap_player_left1 = val
	AudioServer.get_bus_effect(1,0).tap1_delay_ms = val
	
func _delaytap_player_left2_setter(val):
	delaytap_player_left2 = val
	AudioServer.get_bus_effect(1,0).tap2_delay_ms = val

func _feedback_player_left_setter(val):
	feedback_player_left = val
	AudioServer.get_bus_effect(1,0).feedback_delay_ms = val

func _delaytap_player_left1_getter():
	return AudioServer.get_bus_effect(1,0).tap1_delay_ms
	
func _delaytap_player_left2_getter():
	return AudioServer.get_bus_effect(1,0).tap2_delay_ms
	
func _feedback_player_left_getter():
	return AudioServer.get_bus_effect(1,0).feedback_delay_ms

#delay times for player_left bus, setting and getting the values

func _delaytap_player_right1_setter(val):
	#when your variable is 'set', this code is executed.
	delaytap_player_left1 = val
	AudioServer.get_bus_effect(2,0).tap1_delay_ms = val
	
func _delaytap_player_right2_setter(val):
	#when your variable is 'set', this code is executed.
	delaytap_player_left2 = val
	AudioServer.get_bus_effect(2,0).tap2_delay_ms = val
	
func _feedback_player_right_setter(val):
	feedback_player_right = val
	AudioServer.get_bus_effect(2,0).feedback_delay_ms = val
	
func _delaytap_player_right1_getter():
	#when your variable is retrieved, this code is executed.
	return AudioServer.get_bus_effect(2,0).tap1_delay_ms
	
func _delaytap_player_right2_getter():
	#when your variable is retrieved, this code is executed.
	return AudioServer.get_bus_effect(2,0).tap2_delay_ms
	
func _feedback_player_right_getter():
	return AudioServer.get_bus_effect(2,0).feedback_delay_ms


#delay times for backing track bus, left-panned delay setting and getting the values

func _delaytap_backing_left1_setter(val):
	delaytap_backing_left1 = val
	AudioServer.get_bus_effect(3,1).tap1_delay_ms = val
	
func _delaytap_backing_left2_setter(val):
	delaytap_player_left2 = val
	AudioServer.get_bus_effect(3,1).tap2_delay_ms = val

func _feedback_backing_left_setter(val):
	feedback_player_left = val
	AudioServer.get_bus_effect(3,1).feedback_delay_ms = val

func _delaytap_backing_left1_getter():
	return AudioServer.get_bus_effect(3,1).tap1_delay_ms
	
func _delaytap_backing_left2_getter():
	return AudioServer.get_bus_effect(3,1).tap2_delay_ms
	
func _feedback_backing_left_getter():
	return AudioServer.get_bus_effect(3,1).feedback_delay_ms

#delay times for backing track bus, right-panned delay setting and getting the values

func _delaytap_backing_right1_setter(val):
	#when your variable is 'set', this code is executed.
	delaytap_backing_left1 = val
	AudioServer.get_bus_effect(3,2).tap1_delay_ms = val
	
func _delaytap_backing_right2_setter(val):
	#when your variable is 'set', this code is executed.
	delaytap_player_left2 = val
	AudioServer.get_bus_effect(3,2).tap2_delay_ms = val
	
func _feedback_backing_right_setter(val):
	feedback_player_right = val
	AudioServer.get_bus_effect(3,2).feedback_delay_ms = val
	
func _delaytap_backing_right1_getter():
	#when your variable is retrieved, this code is executed.
	return AudioServer.get_bus_effect(3,2).tap1_delay_ms
	
func _delaytap_backing_right2_getter():
	#when your variable is retrieved, this code is executed.
	return AudioServer.get_bus_effect(3,2).tap2_delay_ms
	
func _feedback_backing_right_getter():
	return AudioServer.get_bus_effect(3,2).feedback_delay_ms
