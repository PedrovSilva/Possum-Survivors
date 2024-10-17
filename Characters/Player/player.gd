extends CharacterBody2D


@export var SPEED = 300.0

@onready var animation_tree : AnimationTree = $AnimationTree

var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	animation_tree.active = true
	
func _process(delta: float) -> void:
	update_animation_parameters()

func _physics_process(delta: float) -> void:
	# Add the gravity.

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("ui_left", "ui_right",  "ui_up", "ui_down").normalized()
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func update_animation_parameters() -> void:
	if (velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/is_moving"] = false
		animation_tree["parameters/conditions/idle"] = true

	else:
		animation_tree["parameters/conditions/is_moving"] = true
		animation_tree["parameters/conditions/idle"] = false

	if (direction != Vector2.ZERO):
		animation_tree["parameters/walk/blend_position"] = direction
		animation_tree["parameters/idle/blend_position"] = direction
