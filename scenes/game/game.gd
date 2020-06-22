extends Control


const StateMachineFactory = preload("res://addons/fsm/StateMachineFactory.gd")
const Card = preload("res://scenes/card/card.tscn")
const States = preload("res://scripts/states.gd")
const BlackjackPlayer = preload("res://scripts/blackjack_player.gd")
const BlackjackDeck = preload("res://scripts/blackjack_deck.gd")


const IdleState = States.IdleState
const DealInitialHandsState = States.DealInitialHandsState
const PlayerInputState = States.PlayerInputState


onready var deck_rect: ColorRect = $Control/DeckRect
onready var deal_btn = $DealButton
onready var hit_btn = $HitButton
onready var stand_btn = $StandButton


var deck: BlackjackDeck
var sm: StateMachine
var player : BlackjackPlayer
var dealer : BlackjackPlayer

func _ready():
	deck = BlackjackDeck.new()
	deck.shuffle()

	player = BlackjackPlayer.new(deck, get_player_position())
	dealer = BlackjackPlayer.new(deck, get_dealer_position())
	hit_btn.set_label_text("Hit")
	hit_btn.visible = false
	stand_btn.set_label_text("Stand")
	stand_btn.visible = false
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
				{"id": PlayerInputState.ID, "state": PlayerInputState},
			],
			"transitions":
			[
				{"state_id": IdleState.ID, "to_states": [DealInitialHandsState.ID, PlayerInputState.ID]},
				# {"state_id": IdleState.ID, "to_states": [PlayerInputState.ID]},
				# {"state_id": DealInitialHandsState.ID, "to_states": [IdleState.ID]},
				{"state_id": DealInitialHandsState.ID, "to_states": [PlayerInputState.ID]},
			]
		}
	)


func get_player_position():
	return (
		deal_btn.rect_position
		+ Vector2(-400, (deal_btn.rect_size.y + 25) - Card.instance().rect_size.y)
	)


func get_dealer_position():
	return deck_rect.rect_global_position + Vector2(-400, -25)


func _on_DealButton_pressed():
	sm.transition(DealInitialHandsState.ID)


#func _on_FlipButton_pressed():
#	if dealer_card_2:
#		dealer_card_2.flip_front()


func deal_initial_hands():
	var player_card_1 = player.take_card_face_up()
	deck_rect.add_child(player_card_1)
	player_card_1.move_to(player.get_next_card_position())
	yield(get_tree().create_timer(0.25), "timeout")

	var dealer_card_1 = dealer.take_card_face_up()
	deck_rect.add_child(dealer_card_1)
	dealer_card_1.move_to(dealer.get_next_card_position())
	yield(get_tree().create_timer(0.25), "timeout")

	var player_card_2 = player.take_card_face_up()
	deck_rect.add_child(player_card_2)
	player_card_2.move_to(player.get_next_card_position(), 1)
	yield(get_tree().create_timer(0.3), "timeout")

	var dealer_card_2 = dealer.take_card_face_down()
	deck_rect.add_child(dealer_card_2)
	dealer_card_2.move_to(dealer.get_next_card_position(), 1)
	
	player.adjust_cards()
	dealer.adjust_cards()
