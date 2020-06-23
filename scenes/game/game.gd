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
const StandState = States.StandState

onready var deck_rect: ColorRect = $Control/DeckRect
onready var deal_btn = $DealButton
onready var hit_btn = $HitButton
onready var stand_btn = $StandButton

var deck: BlackjackDeck
var sm: StateMachine
var player: BlackjackPlayer
var dealer: BlackjackPlayer


func _ready():
	deck = BlackjackDeck.new()
	deck.shuffle()

	player = BlackjackPlayer.new(deck, get_player_position())
	dealer = BlackjackPlayer.new(deck, get_dealer_position())
	hit_btn.set_label_text("Hit")
	hit_btn.fade_out()
	stand_btn.set_label_text("Stand")
	stand_btn.fade_out()
	deal_btn.set_label_text("Deal")

	var smf = StateMachineFactory.new()
	sm = smf.create(
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
				{"id": StandState.ID, "state": StandState},
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
				{"state_id": PlayerInputState.ID, "to_states": [HitState.ID, StandState.ID]},
				{"state_id": HitState.ID, "to_states": [PlayerInputState.ID, StandState.ID]},
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
	sm.transition(DealInitialHandsState.ID)


func _on_HitButton_pressed():
	deal_card_face_up_to(player)
	player.adjust_cards()
	# TODO: check player only for blackjack...
	# sm.transition(HitState.ID)


#func _on_FlipButton_pressed():
#	if dealer_card_2:
#		dealer_card_2.flip_front()


func deal_card_face_up_to(_player: Player, duration = 0.5) -> void:
	__move_card_from_deck_to_position(
		_player.take_card_face_up(), _player.get_next_card_position(), duration
	)


func deal_card_face_down_to(_player: Player, duration = 0.5) -> void:
	__move_card_from_deck_to_position(
		_player.take_card_face_down(), _player.get_next_card_position(), duration
	)


func __move_card_from_deck_to_position(card: Card, pos: Vector2, duration) -> void:
	deck_rect.add_child(card)
	card.move_to(pos, duration)


func deal_initial_hands():
	deal_card_face_up_to(player)
	yield(get_tree().create_timer(0.25), "timeout")

	deal_card_face_up_to(dealer)
	yield(get_tree().create_timer(0.25), "timeout")

	deal_card_face_up_to(player, 1)
	yield(get_tree().create_timer(0.3), "timeout")

	deal_card_face_down_to(dealer, 1)

	player.adjust_cards()
	dealer.adjust_cards()

