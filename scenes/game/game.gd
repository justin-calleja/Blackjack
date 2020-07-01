extends Control

const StateMachineFactory = preload("res://addons/fsm/StateMachineFactory.gd")
const Card = preload("res://scenes/card/card.tscn")
const States = preload("res://scripts/states.gd")
const BlackjackPlayer = preload("res://scripts/blackjack_player.gd")
const GamePlayer = preload("res://scripts/game_player.gd")
const BlackjackDeck = preload("res://scripts/blackjack_deck.gd")
const FadeInOutTween = preload("res://scenes/fade_in_out/fade_in_out.tscn")

const DealInitialHandsState = States.DealInitialHandsState
const PlayerInputState = States.PlayerInputState
const HitState = States.HitState
const StandState = States.StandState
const GameOverState = States.GameOverState

onready var deck_rect: ColorRect = $Control/DeckRect
onready var deal_btn = $DealButton
onready var hit_btn = $HitButton
onready var stand_btn = $StandButton

var deck: BlackjackDeck
var state_machine: StateMachine
var player: GamePlayer
var dealer: GamePlayer


func _ready():
	var card_names = BlackjackDeck.CARD_VALUES.keys()
	card_names.erase("back")
	deck = BlackjackDeck.new(card_names)
	deck.shuffle()

	player = GamePlayer.new(BlackjackPlayer.new(deck, get_player_position()), 'player')
	dealer = GamePlayer.new(BlackjackPlayer.new(deck, get_dealer_position()), 'dealer')
	add_child(player)
	add_child(dealer)

	deal_btn.tween = FadeInOutTween.instance()
	hit_btn.tween = FadeInOutTween.instance()
	stand_btn.tween = FadeInOutTween.instance()
	deal_btn.label_text = "Deal"
	deal_btn.fade_in()
	hit_btn.label_text = "Hit"
	hit_btn.fade_out()
	stand_btn.label_text = "Stand"
	stand_btn.fade_out()

	var smf = StateMachineFactory.new()
	state_machine = smf.create(
		{
			"target": self,
			"current_state": PlayerInputState.ID,
			"states":
			[
				{"id": DealInitialHandsState.ID, "state": DealInitialHandsState},
				{"id": PlayerInputState.ID, "state": PlayerInputState},
				{"id": GameOverState.ID, "state": GameOverState},
				{"id": HitState.ID, "state": HitState},
				{"id": StandState.ID, "state": StandState},
			],
			"transitions":
			[
				{
					"state_id": DealInitialHandsState.ID,
					"to_states": [PlayerInputState.ID, GameOverState.ID],
				},
				{
					"state_id": PlayerInputState.ID,
					"to_states":
					[HitState.ID, StandState.ID, GameOverState.ID, DealInitialHandsState.ID]
				},
				{
					"state_id": HitState.ID,
					"to_states":
					[
						PlayerInputState.ID,
						GameOverState.ID,
					]
				},
				{"state_id": StandState.ID, "to_states": [GameOverState.ID]},
				{"state_id": GameOverState.ID, "to_states": [PlayerInputState.ID]},
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


func _on_StandButton_pressed():
	state_machine.transition(StandState.ID)


func move_card_from_deck_to_position(card: Card, pos: Vector2, duration = 0.5) -> void:
	deck_rect.add_child(card)
	card.move_to(pos, duration)


func deal_initial_hands():
	move_card_from_deck_to_position(player.take_card_face_up(), player.get_next_card_position())
	yield(get_tree().create_timer(0.25), "timeout")

	move_card_from_deck_to_position(dealer.take_card_face_up(), dealer.get_next_card_position())
	yield(get_tree().create_timer(0.25), "timeout")

	move_card_from_deck_to_position(player.take_card_face_up(), player.get_next_card_position(), 1)
	yield(get_tree().create_timer(0.3), "timeout")

	move_card_from_deck_to_position(
		dealer.take_card_face_down(), dealer.get_next_card_position(), 1
	)

	player.adjust_cards()
	dealer.adjust_cards()
