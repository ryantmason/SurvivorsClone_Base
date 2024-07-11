extends Area2D

@export var damage = 1
@onready var collision = $CollisionShape2D
@onready var disable_hitbox_timer = $DisableTimer

func tempdisable():
	collision.call_deferred("set","disabled",true)
	disable_hitbox_timer.start()


func _on_disable_timer_timeout():
	collision.call_deferred("set","disabled",false)
