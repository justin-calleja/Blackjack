extends Control

onready var deck: Deck = $Control/Deck
onready var deal_btn = $DealButton
var Utils = preload("res://scripts/utils.gd")
var Card = preload("res://scenes/card/card.tscn")

var player_card_1 : Card
var player_card_2 : Card
var dealer_card_1 : Card
var dealer_card_2 : Card

enum States {
	IDLE,
	DEAL_INITIAL_HANDS,
}


enum Events {
	DEAL,
	DEAL_DONE,
	HIT,
	PLAYER_LOSE,
	PLAYER_WIN,
	STAND
}

var state = States.IDLE


const transitions = {
	[States.IDLE, Events.DEAL]: States.DEAL_INITIAL_HANDS,
	[States.DEAL_INITIAL_HANDS, Events.DEAL_DONE]: States.IDLE,
	[States.DEAL_INITIAL_HANDS, Events.DEAL_DONE]: States.IDLE,

	# [States.HIT_IN_PROGRESS, Events.HIT]: States.HIT_IN_PROGRESS,
}


func _ready():
	init_deck()


func init_deck():
	var card_names = Utils.CARDS.keys()
	card_names.erase("back")
	deck.init(card_names)
	deck.shuffle()


func change_state(event):
	var transition = [state, event]
	if not transition in transitions:
		print_debug('No transition when in state: ' + str(state) + ' and given event: ' + str(event))
		return
	
	state = transitions[transition]
	match state:
		States.DEAL_INITIAL_HANDS:
			# TODO:
			# deal_btn.visible = false
			deal_initial_hands()


func take_card_from_deck(is_face_up = true) -> Card:
	var card_name = deck.deal()
	if card_name == null: return null

	var card = Card.instance()
	card.init(Utils.CARDS[card_name], Utils.CARDS["back"], is_face_up)
	deck.add_child(card)
	return card


func _on_DealButton_pressed():
	change_state(Events.DEAL)
	

func _on_FlipButton_pressed():
	if dealer_card_2:
		dealer_card_2.flip_front()



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
