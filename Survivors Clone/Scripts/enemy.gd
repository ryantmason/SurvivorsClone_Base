extends CharacterBody2D

@export var movement_speed = 20.0 # By exporting this variable each instance of the scene in our game can be modified in the Inspector window on the right to have different movement speeds
@export var hp = 10
@onready var player = get_tree().get_first_node_in_group("player") # grabbing from the player group we have created (first node would be the player scene)
@onready var sprite_2d = $Sprite2D
@onready var anim = $AnimationPlayer

func _ready():
	anim.play("walk")


func _physics_process(_delta): # _ (underscore) before parameter name tells godot we dont want to use it
	var direction = global_position.direction_to(player.global_position)
	
	# instead of using 0 we use 0.1 and -0.1 to reduce insesant flipping
	if direction.x > 0.1:
		sprite_2d.flip_h = true
	elif direction.x < -0.1:
		sprite_2d.flip_h = false
	
	velocity = direction*movement_speed
	move_and_slide()


func _on_hurt_box_hurt(damage):
	hp -= damage
	if hp <- 0:
		queue_free()
