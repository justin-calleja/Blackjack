var cards = []
var deck: Deck
var position: Vector2
# The distance between cards in a player's hand (so you can see all cards)
var cards_x_offset: int

func _init(_deck, _position, _cards_x_offset = 50):
	deck = _deck
	position = _position
	cards_x_offset = _cards_x_offset


func __take_card(duration, is_face_up = true):
	var card = deck.take_card_face_up() if is_face_up else deck.take_card_face_down()
	cards.append(card)
	return card


func take_card_face_up(duration = 0.5):
	return __take_card(duration, true)


func take_card_face_down(duration = 0.5):
	return __take_card(duration, false)


func get_next_card_position():
	return position + Vector2(cards_x_offset * cards.size(), 0)


func adjust_cards():
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


func get_number_of_cards_held():
	return cards.size()


func has_blackjack():
	pass
	# var values = []
	# for card in cards:
	# 	card.value
