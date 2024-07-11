extends CharacterBody2D


var movement_speed = 40.0
var hp = 80
@onready var sprite_2d = $Sprite2D
@onready var walk_timer = get_node("%walkTimer")


func _physics_process(delta): # runs every 1/60th of a frame
	movement()

# my movement
func movement():
	var direction = Input.get_vector("left","right","up","down") # (0, 0) static, (-1, 0) left, (1, 0) right, (0, -1) up, (0, 1) down
	
	if direction.x > 0:
		sprite_2d.flip_h = true
	elif direction.x < 0:
		sprite_2d.flip_h = false
		
		if direction != Vector2.ZERO: # movement is occuring
			if walk_timer.is_stopped(): # timer isnt running
				if sprite_2d.frame >= sprite_2d.hframes - 1: # hframes start at 1 normal frames start at 0
					sprite_2d.frame = 0 
				else:
					sprite_2d.frame += 1
				walk_timer.start()

	velocity = direction.normalized() * movement_speed # needed for character 2d elements
	move_and_slide() # built in function so that godot knows we want it to move, also automatically uses delta in its calculations (but when creating own movement system, utilize delta)


func _on_hurt_box_hurt(damage):
	hp -= damage
	print("HP: ", hp)
