extends Node2D

const BlackjackPlayer = preload("res://scripts/blackjack_player.gd")
const FadeInOutTween = preload("res://scenes/fade_in_out/fade_in_out.tscn")
const GameOverLabel = preload("res://scenes/label/label.tscn")

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
	add_child(tween)

func get_next_card_position() -> Vector2:
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


func show_game_over_label(a_label_text):
	game_over_label.visible = true
	game_over_label.label_text = a_label_text
	tween.fade_in(game_over_label)


func hide_game_over_label():
	tween.fade_out(game_over_label)
