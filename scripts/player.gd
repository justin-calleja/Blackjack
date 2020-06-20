var cards = []
var deck: Deck
var pos: Vector2
var next_card_x_offset: int


func _init(_deck, _pos, _next_card_x_offset = 50):
	deck = _deck
	pos = _pos
	print(pos)
	next_card_x_offset = _next_card_x_offset


func _take_card(duration, is_face_up = true):
	var card = deck.take_card_face_up() if is_face_up else deck.take_card_face_down()
	var next_card_position = get_next_card_position()
	print(next_card_position)
	card.move_to(next_card_position, duration)
	# make sure to append after getting the next card position:
	cards.append(card)
	adjust_cards()
	return card


func take_card_face_up(duration = 0.5):
	return _take_card(duration, true)


func take_card_face_down(duration = 0.5):
	return _take_card(duration, false)


func get_next_card_position():
	return pos + Vector2(next_card_x_offset * cards.size(), 0)


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

