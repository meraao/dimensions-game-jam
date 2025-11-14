extends Control

var target_words = ["acorn", "trap", "leaf"]  # required words
var found_words = []

var letter_grid = [
	"a","c","o","r",
	"t","r","a","p",
	"l","e","a","f"
]

var current_selection := []
var is_dragging := false

func _ready():
	$Panel/ClaimButton.disabled = true
	build_grid()
func build_grid():
	var grid = $Panel/LetterGrid
	grid.columns = 4
	grid.clear()

	var tile_scene = load("res://LetterTile.tscn")

	for letter in letter_grid:
		var tile = tile_scene.instantiate()
		tile.set_letter(letter)
		tile.connect("pressed", self, "_on_tile_pressed")
		tile.connect("hovered", self, "_on_tile_hovered")
		grid.add_child(tile)
func _on_tile_pressed(tile):
	reset_all_tiles()
	is_dragging = true
	current_selection.clear()

	current_selection.append(tile)
	tile.highlight()
	update_preview()
func _on_tile_hovered(tile):
	if not is_dragging:
		return
	if tile not in current_selection:
		current_selection.append(tile)
		tile.highlight()
		update_preview()
func update_preview():
	var word := ""
	for t in current_selection:
		word += t.letter
	$Panel/WordPreview.text = word
func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.pressed and is_dragging:
			is_dragging = false
			process_selected_word()
func process_selected_word():
	var word := ""
	for tile in current_selection:
		word += tile.letter

	if word in target_words and word not in found_words:
		found_words.append(word)
		update_found_label()

		# All words found
		if found_words.size() == target_words.size():
			$Panel/ClaimButton.disabled = false

	# Reset regardless of match
	reset_all_tiles()
	current_selection.clear()
	$Panel/WordPreview.text = ""
func reset_all_tiles():
	for tile in $Panel/LetterGrid.get_children():
		tile.reset_highlight()

func update_found_label():
	$Panel/FoundWordsLabel.text = "Found: " + ", ".join(found_words)
func _on_ClaimButton_pressed():
	hide()
	emit_signal("puzzle_completed")
