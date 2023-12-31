extends CanvasLayer

@onready var bulletsLabel: Label = $ProjectilesContainer/Projectiles/BulletCounter/VBoxContainer/BulletsCount
@onready var grenadesLabel: Label = $ProjectilesContainer/Projectiles/GrenadeCounter/VBoxContainer/GrenadesCount
@onready var playerHealthProgressBar: TextureProgressBar = $HeatlBarContainer/HealthBar
@onready var bulletsImage: TextureRect = $ProjectilesContainer/Projectiles/BulletCounter/VBoxContainer/BulletsImage
@onready var grenadesImage: TextureRect = $ProjectilesContainer/Projectiles/GrenadeCounter/VBoxContainer/GrenadeImage


func _ready():
	Globals.connect("state_changed", update_stats_texts)

func update_stats_texts():
	updateBulletsText()
	updateGrenadesText()
	updatePlayerHealthProgress()

func update_color(amount: int, label: Label, icon: TextureRect):
	if amount <= 0:
		label.modulate = Globals.red
		icon.modulate = Globals.red
	else:
		label.modulate = Globals.green
		icon.modulate = Globals.green

func updateBulletsText():
	bulletsLabel.text = str(Globals.bullets_amount)
	update_color(Globals.bullets_amount, bulletsLabel, bulletsImage)

func updateGrenadesText():
	grenadesLabel.text = str(Globals.grenades_amount)
	update_color(Globals.grenades_amount, grenadesLabel, grenadesImage)

func updatePlayerHealthProgress():
	playerHealthProgressBar.value = Globals.player_health
