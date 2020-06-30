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

"""
Returns the hand's best value or 0 if bust. The best value is always the highest value which is not bust.
A bust value is a value above 21.
"""
func get_best_hand_total() -> int:
	return __get_best_hand_total(0, get_highest_hand_values())


func __get_best_hand_total(best_total: int, card_values: Array) -> int:
	var new_best_total = 0
	var alternative_card_values = []

	for card_value in card_values:
		new_best_total += card_value
		if card_value == 11 and alternative_card_values.empty():
			alternative_card_values = __pure_replace_first_11_with_1(card_values)

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


func get_hand_info() -> Dictionary:
	var best_hand_total = get_best_hand_total()
	print('%s> best_hand_total: %s' % [name, best_hand_total])
	print('%s> %s' % [name, PoolStringArray(get_highest_hand_values()).join(" ")])
	return {
		"is_blackjack": best_hand_total == 21,
		"is_bust": best_hand_total == 0,
		"should_dealer_stand": best_hand_total >= 17,
		"best_hand_total": best_hand_total,
	}

