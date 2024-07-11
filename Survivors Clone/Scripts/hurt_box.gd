extends Area2D

@export_enum("Cooldown", "HitOnce","DisableHitBox") var HurtBoxType = 0 # 0 1 2

@onready var collision = $CollisionShape2D
@onready var disable_hurtbox_timer = $DisableHurtboxTimer

signal hurt(damage)

func _on_area_entered(area):
	if area.is_in_group("attack"):
		if not area.get("damage") == null:
			match HurtBoxType:
				0: # Cooldown
					collision.call_deferred("set","disabled",true)
					disable_hurtbox_timer.start()
				1: # HitOnce
					pass
				2: # Disable hit box
					if area.has_method("tempdisable"):
						area.tempdisable()
			var damage = area.damage
			emit_signal("hurt",damage)


func _on_disable_hurtbox_timer_timeout():
	collision.call_deferred("set","disabled",false)
