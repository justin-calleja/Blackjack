extends "res://scripts/playing_cards_deck.gd"


func _init(card_names).(card_names):
	pass


func card_name_to_value(card_name) -> int:
	return CARD_VALUES[card_name].value


func card_name_to_alt_value(card_name) -> int:
	return CARD_VALUES[card_name].alt_value if CARD_VALUES[card_name].has("alt_value") else 0


func card_name_to_highest_value(card_name) -> int:
	var value = card_name_to_value(card_name)
	var alt_value = card_name_to_alt_value(card_name)
	return value if value > alt_value else alt_value


const CARD_VALUES = {
	"1_club":
	{
		"value": 11,
		"alt_value": 1,
	},
	"1_diamond":
	{
		"value": 11,
		"alt_value": 1,
	},
	"1_heart":
	{
		"value": 11,
		"alt_value": 1,
	},
	"1_spade":
	{
		"value": 11,
		"alt_value": 1,
	},
	"2_club":
	{
		"value": 2,
	},
	"2_diamond":
	{
		"value": 2,
	},
	"2_heart":
	{
		"value": 2,
	},
	"2_spade":
	{
		"value": 2,
	},
	"3_club":
	{
		"value": 3,
	},
	"3_diamond":
	{
		"value": 3,
	},
	"3_heart":
	{
		"value": 3,
	},
	"3_spade":
	{
		"value": 3,
	},
	"4_club":
	{
		"value": 4,
	},
	"4_diamond":
	{
		"value": 4,
	},
	"4_heart":
	{
		"value": 4,
	},
	"4_spade":
	{
		"value": 4,
	},
	"5_club":
	{
		"value": 5,
	},
	"5_diamond":
	{
		"value": 5,
	},
	"5_heart":
	{
		"value": 5,
	},
	"5_spade":
	{
		"value": 5,
	},
	"6_club":
	{
		"value": 6,
	},
	"6_diamond":
	{
		"value": 6,
	},
	"6_heart":
	{
		"value": 6,
	},
	"6_spade":
	{
		"value": 6,
	},
	"7_club":
	{
		"value": 7,
	},
	"7_diamond":
	{
		"value": 7,
	},
	"7_heart":
	{
		"value": 7,
	},
	"7_spade":
	{
		"value": 7,
	},
	"8_club":
	{
		"value": 8,
	},
	"8_diamond":
	{
		"value": 8,
	},
	"8_heart":
	{
		"value": 8,
	},
	"8_spade":
	{
		"value": 8,
	},
	"9_club":
	{
		"value": 9,
	},
	"9_diamond":
	{
		"value": 9,
	},
	"9_heart":
	{
		"value": 9,
	},
	"9_spade":
	{
		"value": 9,
	},
	"10_club":
	{
		"value": 10,
	},
	"10_diamond":
	{
		"value": 10,
	},
	"10_heart":
	{
		"value": 10,
	},
	"10_spade":
	{
		"value": 10,
	},
	"back":
	{
		"value": 0,
	},
	"jack_club":
	{
		"value": 10,
	},
	"jack_diamond":
	{
		"value": 10,
	},
	"jack_heart":
	{
		"value": 10,
	},
	"jack_spade":
	{
		"value": 10,
	},
	"king_club":
	{
		"value": 10,
	},
	"king_diamond":
	{
		"value": 10,
	},
	"king_heart":
	{
		"value": 10,
	},
	"king_spade":
	{
		"value": 10,
	},
	"queen_club":
	{
		"value": 10,
	},
	"queen_diamond":
	{
		"value": 10,
	},
	"queen_heart":
	{
		"value": 10,
	},
	"queen_spade":
	{
		"value": 10,
	},
}
