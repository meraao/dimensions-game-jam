extends TileMap
@onready var puzzle = $PuzzlePopup

func _ready():
	pickup.connect("element_triggered", self, "_open_puzzle")
	puzzle.connect("puzzle_completed", self, "_reward_player")

func _open_puzzle():
	puzzle.visible = true

func _reward_player():
	print("Puzzle completed, item collected!")
