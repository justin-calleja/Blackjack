extends Control

const StateMachineFactory = preload("res://addons/godot-finite-state-machine/state_machine_factory.gd")
const Utils = preload("res://scripts/utils.gd")
const Card = preload("res://scenes/card/card.tscn")
# const States
const States = preload("res://scripts/states.gd")
#const IdleState = preload("res://scripts/idle_state.gd")
#const DealInitialHandsState = preload("res://scripts/deal_initial_hands_state.gd")
#var SM = preload("res://scripts/state_machine.gd"
#var sm: SM = null

onready var deck: Deck = $Control/Deck
onready var deal_btn = $DealButton
onready var hit_btn = $HitButton


var player_card_1 : Card
var player_card_2 : Card
var dealer_card_1 : Card
var dealer_card_2 : Card

var IdleState = States.IdleState
var DealInitialHandsState = States.DealInitialHandsState
# const a = States.IdleState
# const DealInitialHandsState = States.DealInitialHandsState

#enum States {
#	IDLE,
#	DEAL_INITIAL_HANDS,
#}
#
#
#enum Events {
#	DEAL,
#	DEAL_DONE,
#	HIT,
#	PLAYER_LOSE,
#	PLAYER_WIN,
#	STAND
#}
#
#var state = States.IDLE
#
#
#const transitions = {
#	[States.IDLE, Events.DEAL]: States.DEAL_INITIAL_HANDS,
#	[States.DEAL_INITIAL_HANDS, Events.DEAL_DONE]: States.IDLE,
#	[States.DEAL_INITIAL_HANDS, Events.DEAL_DONE]: States.IDLE,
#
#	# [States.HIT_IN_PROGRESS, Events.HIT]: States.HIT_IN_PROGRESS,
#}


var sm

func _ready():
	hit_btn.set_label_text(("Hit"))
	hit_btn.visible = false
	deal_btn.set_label_text("Deal")
	init_deck()
	
	var smf = StateMachineFactory.new()
	sm = smf.create({
		"target": self,
		"current_state": "idle",
		"states": [
			{"id": IdleState.ID, "state": IdleState},
			{"id": DealInitialHandsState.ID, "state": DealInitialHandsState},
		],
		"transitions": [
			{ "state_id": IdleState.ID, "to_states": [ DealInitialHandsState.ID] },
			{ "state_id":  DealInitialHandsState.ID, "to_states": [IdleState.ID] },
		]
	})


func init_deck():
	var card_names = Utils.CARDS.keys()
	card_names.erase("back")
	deck.init(card_names)
	deck.shuffle()


#func change_state(event):
#	var transition = [state, event]
#	if not transition in transitions:
#		print_debug('No transition when in state: ' + str(state) + ' and given event: ' + str(event))
#		return
#
#	state = transitions[transition]
#	match state:
#		States.DEAL_INITIAL_HANDS:
#			# TODO
#			# deal_btn.visible = false
#			deal_initial_hands()


func take_card_from_deck(is_face_up = true) -> Card:
	var card_name = deck.deal()
	if card_name == null: return null

	var card = Card.instance()
	card.init(Utils.CARDS[card_name], Utils.CARDS["back"], is_face_up)
	deck.add_child(card)
	return card


#func enter_state(state):
#	match state:
#		SM.States.DEAL_INITIAL_HANDS:
#			print('in here....')
#			# TODO
##			# deal_btn.visible = false
#			deal_initial_hands()

func _on_DealButton_pressed():
	sm.transition("deal_initial_hands")
#	sm.change_state(SM.Events.DEAL)
#	change_state(Events.DEAL)
	

#func _on_FlipButton_pressed():
#	if dealer_card_2:
#		dealer_card_2.flip_front()



func deal_initial_hands():
	player_card_1 = take_card_from_deck()
	var pos1 = deal_btn.rect_position + Vector2(-400, (deal_btn.rect_size.y + 25) - player_card_1.rect_size.y)
	player_card_1.move_to(pos1)
	yield(get_tree().create_timer(0.25), "timeout")
	
	dealer_card_1 = take_card_from_deck()
	var pos2 = deck.rect_global_position + Vector2(-400, -25)
	dealer_card_1.move_to(pos2)
	yield(get_tree().create_timer(0.25), "timeout")
	
	player_card_2 = take_card_from_deck()
	player_card_2.rect_rotation = 3
	var pos3 = deal_btn.rect_position + Vector2(-350, (deal_btn.rect_size.y + 25) - player_card_2.rect_size.y)
	player_card_2.move_to(pos3, 1)
	yield(get_tree().create_timer(0.3), "timeout")
	
	dealer_card_2 = take_card_from_deck(false)
	dealer_card_2.rect_rotation = 3
	var pos4 = deck.rect_global_position + Vector2(-350, -25)
	dealer_card_2.move_to(pos4, 1)
