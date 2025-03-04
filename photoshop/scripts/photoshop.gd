class_name photoshop
extends CharacterBody2D

@export var attack_damage := 10  
@export var attack_cooldown := 1.5  

func enemy():
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()


	if velocity.length() >= 0:
		$AnimatedSprite2D.play("idle")
