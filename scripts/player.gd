class_name Player

var cards = []
var deck: PlayingCardsDeck
var position: Vector2
# The distance between cards in a player's hand (so you can see all cards)
var cards_x_offset: int
var name = 'anon'


func _init(a_deck, a_position, a_cards_x_offset = 50):
	deck = a_deck
	position = a_position
	cards_x_offset = a_cards_x_offset


func take_card_face_up(card_name: String = "") -> Card:
	return __take_card(card_name, true)


func take_card_face_down(card_name: String = "") -> Card:
	return __take_card(card_name, false)


func __take_card(card_name: String, is_face_up: bool) -> Card:
	var card = (
		deck.take_card_face_up(card_name)
		if is_face_up
		else deck.take_card_face_down(card_name)
	)
	cards.append(card)
	return card


func get_next_card_position() -> Vector2:
	return position + Vector2(cards_x_offset * cards.size(), 0)


func adjust_cards() -> void:
	match cards.size():
		1:
			return
		2:
			cards.back().rect_rotation = 3
		var size:
			for i in size:
				if i == 0:
					cards[i].rect_rotation = -3
				elif i == size - 1:
					cards[i].rect_rotation = 3
				else:
					cards[i].rect_rotation = 0


func get_number_of_cards_held() -> int:
	return cards.size()


func discard_cards() -> void:
	for card in cards:
		card.discard()
	cards = []
	
