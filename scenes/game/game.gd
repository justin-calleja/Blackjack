extends Control

const StateMachineFactory = preload("res://addons/fsm/StateMachineFactory.gd")
const Card = preload("res://scenes/card/card.tscn")
const States = preload("res://scripts/states.gd")
const BlackjackPlayer = preload("res://scripts/blackjack_player.gd")
const BlackjackDeck = preload("res://scripts/blackjack_deck.gd")

const StartState = States.StartState
const DealInitialHandsState = States.DealInitialHandsState
const PlayerInputState = States.PlayerInputState
const PlayerBlackjackState = States.PlayerBlackjackState
const DealerBlackjackState = States.DealerBlackjackState
const HitState = States.HitState
# const StandState = States.StandState
const PlayerLoseState = States.PlayerLoseState

onready var deck_rect: ColorRect = $Control/DeckRect
onready var deal_btn = $DealButton
onready var hit_btn = $HitButton
onready var stand_btn = $StandButton

var deck: BlackjackDeck
var state_machine: StateMachine
var player: BlackjackPlayer
var dealer: BlackjackPlayer


func _ready():
	var card_names = BlackjackDeck.CARD_VALUES.keys()
	card_names.erase("back")
	deck = BlackjackDeck.new(card_names)
	deck.shuffle()

	player = BlackjackPlayer.new(deck, get_player_position())
	player.name = 'player'
	dealer = BlackjackPlayer.new(deck, get_dealer_position())
	dealer.name = 'dealer'
	hit_btn.label = "Hit"
	hit_btn.fade_out()
	stand_btn.label = "Stand"
	stand_btn.fade_out()
	deal_btn.label = "Deal"

	var smf = StateMachineFactory.new()
	state_machine = smf.create(
		{
			"target": self,
			"current_state": StartState.ID,
			"states":
			[
				{"id": StartState.ID, "state": StartState},
				{"id": DealInitialHandsState.ID, "state": DealInitialHandsState},
				{"id": PlayerInputState.ID, "state": PlayerInputState},
				{"id": PlayerBlackjackState.ID, "state": PlayerBlackjackState},
				{"id": DealerBlackjackState.ID, "state": DealerBlackjackState},
				{"id": HitState.ID, "state": HitState},
				{"id": PlayerLoseState.ID, "state": PlayerLoseState},
			],
			"transitions":
			[
				{
					"state_id": StartState.ID,
					"to_states":
					[
						DealInitialHandsState.ID,
					]
				},
				{
					"state_id": DealInitialHandsState.ID,
					"to_states":
					[PlayerInputState.ID, PlayerBlackjackState.ID, DealerBlackjackState.ID],
				},
				{
					"state_id": PlayerInputState.ID,
					"to_states": [PlayerLoseState.ID, PlayerBlackjackState.ID, HitState.ID]
				},
				{
					"state_id": HitState.ID,
					"to_states": [PlayerInputState.ID, PlayerBlackjackState.ID, PlayerLoseState.ID]
				},
				{"state_id": PlayerBlackjackState.ID, "to_states": [PlayerInputState.ID]},
				{"state_id": PlayerLoseState.ID, "to_states": [PlayerInputState.ID]},
			]
		}
	)


func get_player_position():
	return (
		deal_btn.rect_position
		+ Vector2(-500, (deal_btn.rect_size.y + 25) - Card.instance().rect_size.y)
	)


func get_dealer_position():
	return deck_rect.rect_global_position + Vector2(-500, -25)


func _on_DealButton_pressed():
	state_machine.transition(DealInitialHandsState.ID)


func _on_HitButton_pressed():
	state_machine.transition(HitState.ID)


#func _on_FlipButton_pressed():
#	if dealer_card_2:
#		dealer_card_2.flip_front()


func move_card_from_deck_to_position(card: Card, pos: Vector2, duration = 0.5) -> void:
	deck_rect.add_child(card)
	card.move_to(pos, duration)


func deal_initial_hands():
	move_card_from_deck_to_position(
		player.take_card_face_up("1_club"), player.get_next_card_position()
	)
	yield(get_tree().create_timer(0.25), "timeout")

	move_card_from_deck_to_position(dealer.take_card_face_up(), dealer.get_next_card_position())
	yield(get_tree().create_timer(0.25), "timeout")

	move_card_from_deck_to_position(
		player.take_card_face_up("king_club"), player.get_next_card_position(), 1
	)
	yield(get_tree().create_timer(0.3), "timeout")

	move_card_from_deck_to_position(
		dealer.take_card_face_down(), dealer.get_next_card_position(), 1
	)
	print('d')

	player.adjust_cards()
	dealer.adjust_cards()
