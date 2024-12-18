extends CharacterBody2D


@onready var player = get_node("/root/Game/Player")
@export var mobSpeed = 150
signal kill
var health = 3

func _ready() -> void:
	%Slime.play_walk()

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	
	velocity = direction * mobSpeed
	
	move_and_slide()
	
func take_damage() -> void:
	health -= 1
	
	%Hit.play()
	%Slime.play_hurt()
	
	if health == 0:
		kill.emit()
		queue_free()
		
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		
		get_parent().add_child(smoke)
		
		smoke.global_position = global_position
		
