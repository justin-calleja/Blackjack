extends "res://scripts/player.gd"
class_name BlackjackPlayer


#https://docs.godotengine.org/en/stable/getting_started/scripting/gdscript/gdscript_basics.html#class-constructor
func _init(_deck, _position, _cards_x_offset = 50).(_deck, _position, _cards_x_offset):
	pass


func get_highest_hand_values() -> Array:
	var result = []
	for card in cards:
		result.append(deck.card_name_to_highest_value(card.get_name()))
	return result


func get_cards_total(card_values: Array) -> int:
	var total = 0
	for card_value in card_values:
		total += card_value
	return total


func get_best_hand_total() -> int:
	return __get_best_hand_total(0, get_highest_hand_values())


func __get_best_hand_total(best_total: int, card_values: Array) -> int:
	var new_best_total = 0
	var alternative_card_values = []

	for card_value in card_values:
		new_best_total += card_value
		if card_value == 11 and alternative_card_values.empty():
			alternative_card_values = __pure_replace_first_11_with_1(card_values)

	# alternative_card_values (if they exist) can only be less than the new_best_total
	if not alternative_card_values.empty():
		assert(get_cards_total(alternative_card_values) < new_best_total, "")

	if new_best_total <= 21:
		# Since this new_best_total is not bust (over 21), there is no point in calculating
		# another new_best_total even if there is an alternative_card_values.
		# This is because alternative_card_values must always be less in total than new_best_total.
		# This is because we always start with ace values of 11 and demote to 1 progressively.
		return new_best_total if new_best_total > best_total else best_total
	else:
		# new_best_total is bust
		if alternative_card_values.empty():
			return best_total
		else:
			return __get_best_hand_total(best_total, alternative_card_values)


func __pure_replace_first_11_with_1(values: Array):
	var result = []
	var replaced = false

	for value in values:
		if value == 11 and not replaced:
			result.append(1)
			replaced = true
		else:
			result.append(value)

	return result


func has_blackjack():
	return get_best_hand_total() == 21
	# var player_total = player.get_best_hand_total()
	# var dealer_total = dealer.get_best_hand_total()

	# if player_total == 21 and dealer_total == 21:
	# 	# sm.transition("draw")
	# 	return true
	# elif player_total == 21:
	# 	# sm.transition(PlayerBlackjackState.ID)
	# 	return true
	# elif dealer_total == 21:
	# 	# sm.transition(DealerBlackjackState.ID)
	# 	return true
