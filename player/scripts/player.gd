class_name Player
extends CharacterBody2D

@export var move_speed : float = 160.0 
@export var attack_damage : int = 20  

var enemy_in_atack_range = null  
var enemy_atack_cooldwon = true
var health = 100
var player_stamina = 32
var player_alive  = true
var atack_ip = false  
var is_spriting = false
@onready var hbarAnim = $"UI/Health_bar/hbarAnim"

@onready var addStamina = $addStamina
@onready	 var deleteStamina = $deleteStamina

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
	print(player_stamina)
	if event.is_action_pressed("speedplayer"):
		move_speed += 100
		var  is_sprinting = true
		deleteStamina.start()
		addStamina.stop()
	if event.is_action_released("speedplayer"):
		move_speed -= 100
		is_spriting = false
		addStamina.start()
		deleteStamina.stop()
	if player_stamina == 0:
		move_speed = 160
		
func stamina(player_stamina):
	match player_stamina:
		32:	hbarAnim.play("default.32")
		31:	hbarAnim.play("default.31")
		30:	hbarAnim.play("default.30")
		29:	hbarAnim.play("default.29")
		28:	hbarAnim.play("default.28")
		27:	hbarAnim.play("default.27")
		26:	hbarAnim.play("default.26")
		25:	hbarAnim.play("default.25")
		24:	hbarAnim.play("default.24")
		23:	hbarAnim.play("default.23")
		22:	hbarAnim.play("default.22")
		21:	hbarAnim.play("default.21")
		20:	hbarAnim.play("default.20")
		19:	hbarAnim.play("default.19")
		18:	hbarAnim.play("default.18")
		17:	hbarAnim.play("default.17")
		16:	hbarAnim.play("default.16")
		15:	hbarAnim.play("default.15")
		14:	hbarAnim.play("default.14")
		13:	hbarAnim.play("default.13")
		12:	hbarAnim.play("default.12")
		11:	hbarAnim.play("default.11")
		10:	hbarAnim.play("default.10")
		9:	hbarAnim.play("default.9")
		8:	hbarAnim.play("default.8")
		7:	hbarAnim.play("default.7")
		6:	hbarAnim.play("default.6")
		5:	hbarAnim.play("default.5")
		4:	hbarAnim.play("default.4")
		3:	hbarAnim.play("default.3")
		2:	hbarAnim.play("default.2")
		1:	hbarAnim.play("default.1")
		0:	hbarAnim.play("default.0")



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
	
	
#STAMINA


func _on_add_stamina_timeout() -> void:
	if player_stamina < 32:
		player_stamina += 1
		stamina(player_stamina)
	


func _on_delete_stamina_timeout() -> void:
	if player_stamina > 0:
		player_stamina -= 1
		stamina(player_stamina)
		
