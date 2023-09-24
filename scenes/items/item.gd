extends Area2D

const ROTATION_SPEED: int = 8

var availableItems: Array[Dictionary] = [
	{"type": "bullets", "probability": 4, "color": Color(0, 0, 1)},
	{"type": "grenade", "probability": 1, "color": Color(1, 1, 0)},
	{"type": "health", "probability": 1, "color": Color(1, 0, 0)}
]

var itemType

func chooseItem():
	var totalProbability: int = 0
	for item in availableItems:
		totalProbability += item["probability"]

	var randNum: int = randi() % totalProbability
	var cumulativeProb: int = 0

	for item in availableItems:
		cumulativeProb += item["probability"]
		if randNum < cumulativeProb:
			return item

func _ready():
	var chosenItem = chooseItem()
	itemType = chosenItem["type"]
	$ItemImage.modulate = chosenItem["color"]

func _process(delta):
	rotation += ROTATION_SPEED * delta


func _on_body_entered(_body):
	match itemType:
		"bullets":
			Globals.bullets_amount += 15
			if Globals.bullets_amount > Globals.max_bullets_amount:
				Globals.bullets_amount = Globals.max_bullets_amount
		"grenade":
			Globals.grenades_amount += 2
			if Globals.grenades_amount > Globals.max_grenades_amount:
				Globals.grenades_amount = Globals.max_grenades_amount
		"health":
			Globals.player_health += 10
			if Globals.player_health > Globals.max_player_health:
				Globals.player_health = Globals.max_player_health

	queue_free()
