extends state

@export var attack_interval: float = 1.0  
var timer: float = 1.0
var player_in_zone: bool = false

func Enter():
	print("Entering Attack State")
	timer = attack_interval

func Update(delta):
	if player_in_zone:
		timer -= delta
		if timer <= 0:
			attack()
			timer = attack_interval
	else:
		Transitioned.emit(self, "idle") 
		
func attack():
	print("Enemy attacks!")

func Exit():
	print("Exiting Attack State")
