extends Control

const StateMachineFactory = preload("res://addons/fsm/StateMachineFactory.gd")
const Utils = preload("res://scripts/utils.gd")
const Card = preload("res://scenes/card/card.tscn")
const States = preload("res://scripts/states.gd")
const BJ = preload("res://scripts/blackjack.gd")
const Player = preload("res://scripts/player.gd")

const IdleState = States.IdleState
const DealInitialHandsState = States.DealInitialHandsState

onready var deck: Deck = $Control/Deck
onready var deal_btn = $DealButton
onready var hit_btn = $HitButton

var player_card_1: Card
var player_card_2: Card
var dealer_card_1: Card
var dealer_card_2: Card
var sm: StateMachine
var player = Player


func _ready():
	var card = Card.instance()
	player = Player.new(
		deck,
		deal_btn.rect_position + Vector2(-400, (deal_btn.rect_size.y + 25) - card.rect_size.y)
	)
	hit_btn.set_label_text("Hit")
	hit_btn.visible = false
	deal_btn.set_label_text("Deal")

	var smf = StateMachineFactory.new()
	sm = smf.create(
		{
			"target": self,
			"current_state": IdleState.ID,
			"states":
			[
				{"id": IdleState.ID, "state": IdleState},
				{"id": DealInitialHandsState.ID, "state": DealInitialHandsState},
			],
			"transitions":
			[
				{"state_id": IdleState.ID, "to_states": [DealInitialHandsState.ID]},
				{"state_id": DealInitialHandsState.ID, "to_states": [IdleState.ID]},
			]
		}
	)


#func init_deck():
#	var card_names = Utils.CARDS.keys()
#	card_names.erase("back")
#	deck.init(card_names)
#	deck.shuffle()


# func take_card_from_deck(is_face_up = true) -> Card:
# 	var card_name = deck.deal()
# 	if card_name == null:
# 		return null

# 	var card = Card.instance()
# 	card.init(
# 		Utils.CARDS[card_name].png,
# 		Utils.CARDS["back"].png,
# 		is_face_up,
# 		Utils.CARDS[card_name].value,
# 		Utils.CARDS[card_name].alt_value if Utils.CARDS[card_name].has("alt_value") else 0
# 	)
# 	deck.add_child(card)
# 	return card


func _on_DealButton_pressed():
	sm.transition("deal_initial_hands")


#func _on_FlipButton_pressed():
#	if dealer_card_2:
#		dealer_card_2.flip_front()


func deal_initial_hands():
	player.take_card_face_up()
#	player_card_1 = deck.take_card_face_up()
#	var pos1 = (
#		deal_btn.rect_position
#		+ Vector2(-400, (deal_btn.rect_size.y + 25) - player_card_1.rect_size.y)
#	)
#	player_card_1.move_to(pos1)
	yield(get_tree().create_timer(0.25), "timeout")

	dealer_card_1 = deck.take_card_face_up()
	var pos2 = deck.rect_global_position + Vector2(-400, -25)
	dealer_card_1.move_to(pos2)
	yield(get_tree().create_timer(0.25), "timeout")

	player.take_card_face_up(1)
#	player_card_2 = deck.take_card_face_up()
#	player_card_2.rect_rotation = 3
#	var pos3 = (
#		deal_btn.rect_position
#		+ Vector2(-350, (deal_btn.rect_size.y + 25) - player_card_2.rect_size.y)
#	)
#	player_card_2.move_to(pos3, 1)
	yield(get_tree().create_timer(0.3), "timeout")

	dealer_card_2 = deck.take_card_face_down()
	dealer_card_2.rect_rotation = 3
	var pos4 = deck.rect_global_position + Vector2(-350, -25)
	dealer_card_2.move_to(pos4, 1)
	yield(get_tree().create_timer(0.3), "timeout")

	player.take_card_face_up(1)
