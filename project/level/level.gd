class_name Level
extends Node3D

var _ghosts_left : int;
var _ghost_hit_goal := 3;

@onready var _ghost_object : Ghost
@onready var ghosts_left_label: Label = $GhostsLeftLabel
@onready var game_end_label: Label = $GameEndLabel
@onready var hand: Hand = $Hand
@onready var time_left: Timer = $TimeLeft
@onready var time_left_label: Label = $TimeLeftLabel
@onready var main_menu_button: Button = $MainMenuButton

func _ready() -> void:
	_ghosts_left = _ghost_hit_goal;
	ghosts_left_label.text = "Ghosts Left: " + str(_ghosts_left) + " / " + str(_ghost_hit_goal)
	var position_z = randf_range(-5, 5)
	_spawn_ghost(Vector3(6, 0, position_z))
	game_end_label.hide()
	main_menu_button.hide()
	
	
func _physics_process(_delta: float) -> void:
	time_left_label.text = "Time Left: " + str(floor(time_left.time_left))


func _spawn_ghost(old_ghost_position : Vector3) -> void:
	var max_z := 5
	var min_z := -5
	var z_increment := 2
	
	_ghost_object = load("res://ghost/ghost.tscn").instantiate()
	get_parent().add_child(_ghost_object)
	var position_z_positive = clamp(randf_range(old_ghost_position.z + z_increment, max_z), min_z, max_z)
	var position_z_negative = clamp(randf_range(min_z, old_ghost_position.z - z_increment), min_z, max_z)
	var side = randi_range(0, 1)
	if side == 0:
		_ghost_object.global_position = Vector3(6, 0, position_z_positive)
	else:
		_ghost_object.global_position = Vector3(6, 0, position_z_negative)
	_ghost_object.connect("ghost_hit", _on_ghost_entered)


func _on_ghost_entered(old_ghost_position : Vector3) -> void:
	_spawn_ghost(old_ghost_position)
	_ghosts_left -= 1
	ghosts_left_label.text = "Ghosts Left: " + str(_ghosts_left) + " / " + str(_ghost_hit_goal)
	
	if _ghosts_left == 0:
		hand.game_lost = true
		game_end_label.text = "You Win!"
		game_end_label.show()
		time_left.stop()
		main_menu_button.show()
		time_left_label.hide()


func _on_time_left_timeout() -> void:
	hand.game_lost = true
	game_end_label.text = "You Lose!"
	game_end_label.show()
	main_menu_button.show()


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://title/title.tscn")
