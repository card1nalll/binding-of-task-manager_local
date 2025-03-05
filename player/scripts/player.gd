class_name Player
extends CharacterBody2D

@export var move_speed : float = 160.0 
@export var attack_damage : int = 20  

var enemy_in_atack_range = null  
var enemy_atack_cooldwon = true
var health = 100
var player_alive  = true
var atack_ip = false  

@onready var sprite = $AnimatedSprite2D
@onready var attack_timer = $atack_cooldwon

func _physics_process(delta: float) -> void:
	var direction := Vector2.ZERO

	if enemy_in_atack_range:
		enemy_atack()

	if health <= 0:
		player_alive = false
		health = 0
		print("player dead a cause the bug in code")

	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	velocity = direction.normalized() * move_speed  
	move_and_slide()

	if atack_ip == false:  
		if direction.x > 0:
			sprite.play("walk_right")
		elif direction.x < 0:
			sprite.play("walk_left")
		else:
			sprite.play("idle")

	if Input.is_action_just_pressed("left_mouse") and not atack_ip:
		atack()

func _input(event):
	if event.is_action_pressed("speedplayer"):
		move_speed += 100
	if event.is_action_released("speedplayer"):
		move_speed -= 100

func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_atack_range = body  
		Global.player_current_attack = true  

func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_atack_range = null  
		Global.player_current_attack = false  

func enemy_atack():
	if enemy_in_atack_range and enemy_atack_cooldwon:
		health -= 20
		enemy_atack_cooldwon = false
		attack_timer.start()
		print("Player Health:", health)

func _on_atackcooldwon_timeout() -> void:
	enemy_atack_cooldwon = true

func atack():
	atack_ip = true  
	sprite.play("punch")  
	await sprite.animation_finished 

	if enemy_in_atack_range and enemy_in_atack_range.has_method("deal_with_damage"):
		enemy_in_atack_range.deal_with_damage(attack_damage)

	atack_ip = false  
