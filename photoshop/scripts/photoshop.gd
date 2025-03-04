class_name photoshop
extends CharacterBody2D

@export var attack_damage := 10  
@export var attack_cooldown := 1.5  

var health = 100
var player_inatack_zone = false


func enemy():
	pass


func _physics_process(delta: float) -> void:
	move_and_slide()


	if velocity.length() >= 0:
		$AnimatedSprite2D.play("idle")


func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_inatack_zone = true


func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_inatack_zone = false

func deal_with_damage():
	if player_inatack_zone and Global.player_current_atack == true:
		health = health - 20
		print("ae take 20 dage")
