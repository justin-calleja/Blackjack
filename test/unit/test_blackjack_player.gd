extends "res://addons/gut/test.gd"


const BlackjackDeck = preload("res://scripts/blackjack_deck.gd")
const BlackjackPlayer = preload("res://scripts/blackjack_player.gd")


var deck: BlackjackDeck
var player: BlackjackPlayer


func test_blackjack():
	var card_names = [
		"king_club",
		"1_club",
	]
	deck = BlackjackDeck.new(card_names)
	player = BlackjackPlayer.new(deck, Vector2())
	player.take_card_face_up()
	assert_eq(player.get_best_hand_total(), 11, "expected 11 total with an ace in hand")
	player.take_card_face_up()
	assert_eq(
		player.get_best_hand_total(), 21, "expected 21 total with an ace (11) and king (10) in hand"
	)

func test_till_bust():
	var card_names = [
		"5_diamond",
		"9_diamond",
		"jack_club",
		"1_club",
	]
	deck = BlackjackDeck.new(card_names)
	player = BlackjackPlayer.new(deck, Vector2())
	assert_eq(player.get_best_hand_total(), 0, "expected 0 total with an empty hand")
	player.take_card_face_up()
	assert_eq(player.get_best_hand_total(), 11, "expected 11 total with an ace in hand")
	player.take_card_face_up()
	assert_eq(
		player.get_best_hand_total(), 21, "expected 21 total with an ace (11) and jack (10) in hand"
	)
	player.take_card_face_up()
	assert_eq(
		player.get_best_hand_total(),
		20,
		"expected 20 total with an ace (1), jack (10), and 9 in hand"
	)
	player.take_card_face_up()
	assert_eq(
		player.get_best_hand_total(), 0, "expected 0 for a bust hand (total would have been 25)"
	)
