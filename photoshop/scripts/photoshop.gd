class_name photoshop
extends CharacterBody2D

@export var attack_damage := 10  
@export var attack_cooldown := 1.5  

var health = 100
var player_in_atack_zone = false

func enemy():
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()

	if velocity.length() >= 0:
		$AnimatedSprite2D.play("idle")

func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_atack_zone = true

func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_atack_zone = false

func deal_with_damage(damage: int):
	health = health -20
	print("Enemy took", damage, "damage! Current HP:", health)

	if health <= 0:
		queue_free()
