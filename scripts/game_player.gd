extends Node2D

const BlackjackPlayer = preload("res://scripts/blackjack_player.gd")
const FadeInOutTween = preload("res://scenes/fade_in_out/fade_in_out.tscn")
const GameOverLabel = preload("res://scenes/label/label.tscn")
const WinColor: Color = Color8(184, 218, 49)
const LoseColor: Color = Color8(204, 11, 30)
const BlackjackColor: Color = Color8(51, 48, 48)
const DrawColor: Color = Color8(188, 150, 0)

var player: BlackjackPlayer
var game_over_label: GameOverLabel
var tween: FadeInOutTween


func _init(a_player, name):
	position = a_player.position
	player = a_player
	player.name = name


func _ready():
	game_over_label = GameOverLabel.instance()
	tween = FadeInOutTween.instance()

	add_child(game_over_label)
	game_over_label.visible = false
	game_over_label.rect_position += Vector2(90, 90)
	add_child(tween)


func flip_card_at_index(index):
	player.cards[index].flip()

func get_next_card_position() -> Vector2:
	# TODO: maybe this method should actually be implemented here...
	return player.get_next_card_position()


func take_card_face_up(card_name: String = "") -> Card:
	return player.take_card_face_up(card_name)


func take_card_face_down(card_name: String = "") -> Card:
	return player.take_card_face_down(card_name)


func adjust_cards() -> void:
	player.adjust_cards()


func discard_cards() -> void:
	player.discard_cards()


func get_hand_info() -> Dictionary:
	return player.get_hand_info()


func show_win_label():
	game_over_label.color = WinColor
	__show_game_over_label("WIN")


func show_lose_label():
	game_over_label.color = LoseColor
	__show_game_over_label("LOSE")


func show_bust_label():
	game_over_label.color = LoseColor
	__show_game_over_label("BUST")


func show_blackjack_label():
	game_over_label.color = BlackjackColor
	__show_game_over_label("BLACKJACK!")


func show_draw_label():
	game_over_label.color = DrawColor
	__show_game_over_label("DRAW")


func __show_game_over_label(a_label_text):
	game_over_label.visible = true
	game_over_label.label_text = a_label_text
	tween.fade_in(game_over_label)


func hide_game_over_label():
	tween.fade_out(game_over_label)
