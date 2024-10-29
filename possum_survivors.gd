extends Node2D

var score = 0
@onready var scoreLabel = $UserInterface/GameUI/Score

func _on_kill_mob():
	score += 1 
	scoreLabel.text = "Score: %d" % score
	
func spawn_mob() -> void:
	var new_mob = preload("res://Characters/slime/mob_slime.tscn").instantiate()
	new_mob.connect("kill", self._on_kill_mob)
	
	%PathFollow2D.progress_ratio = randf()
	
	new_mob.global_position = %PathFollow2D.global_position
	
	add_child(new_mob)

func _on_timer_timeout() -> void:
	spawn_mob()


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true
	
