require './lib/card'
require "./lib/turn"
require './lib/deck'
require './lib/round'
require 'pry'

RSpec.describe Round do
  it 'exists' do
    deck = []
    round = Round.new(deck)

    expect(round).to be_instance_of(Round)
  end

  it 'has a deck' do
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    cards = [card_1, card_2, card_3]
    deck = Deck.new(cards)
    round = Round.new(deck)

    expect(round.deck).to eq(deck)
  end

  it 'has a current card' do
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    cards = [card_1, card_2, card_3]
    deck = Deck.new(cards)
    round = Round.new(deck)

    expect(round.current_card).to eq(card_1)
  end

  it 'can take a turn' do
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    cards = [card_1, card_2, card_3]
    deck = Deck.new(cards)
    round = Round.new(deck)
    
    expect(round.turns).to eq([])

    new_turn = round.take_turn("Juneau")

    expect(new_turn).to be_instance_of(Turn)
    expect(new_turn.correct?).to be true
    expect(round.turns).to eq([new_turn])
  end

  it 'changes the current card each turn' do
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    cards = [card_1, card_2, card_3]
    deck = Deck.new(cards)
    round = Round.new(deck)
    
    expect(round.current_card).to eq(card_1)
    round.take_turn("Juneau")
    expect(round.current_card).to eq(card_2)
    round.take_turn("ethan")
    expect(round.current_card).to eq(card_3)
  end
  
  it 'can count the number of correct guesses' do
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    cards = [card_1, card_2, card_3]
    deck = Deck.new(cards)
    round = Round.new(deck)

    expect(round.number_correct).to eq(0)
    round.take_turn("Juneau")
    expect(round.number_correct).to eq(1)
    round.take_turn("WRONG ANSWER")
    expect(round.number_correct).to eq(1)
    round.take_turn("North north west")
    expect(round.number_correct).to eq(2)
  end

  it 'can count the number of correct guesses by category' do
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    cards = [card_1, card_2, card_3]
    deck = Deck.new(cards)
    round = Round.new(deck)

    expect(round.number_correct).to eq(0)
    round.take_turn("Juneau")
    expect(round.number_correct_by_category(:Geography)).to eq(1)
    expect(round.number_correct_by_category(:STEM)).to eq(0)
    round.take_turn("WRONG ANSWER")
    expect(round.number_correct_by_category(:Geography)).to eq(1)
    expect(round.number_correct_by_category(:STEM)).to eq(0)
    round.take_turn("North north west")
    expect(round.number_correct_by_category(:Geography)).to eq(1)
    expect(round.number_correct_by_category(:STEM)).to eq(1)
    expect(round.number_correct_by_category("Pop Culture")).to eq(0)
  end

  it 'can calculate the percentage of correct guesses' do
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    cards = [card_1, card_2, card_3]
    deck = Deck.new(cards)
    round = Round.new(deck)

    # binding.pry
    expect(round.percent_correct).to eq(0.0)
    round.take_turn("Juneau")
    expect(round.percent_correct).to eq(100.0)
    round.take_turn("WRONG ANSWER")
    expect(round.percent_correct).to eq(50.0)
    round.take_turn("North north west")
    expect(round.percent_correct).to eq(66.7)
  end

  it 'can calculate the percentage of correct guesses by category' do
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    cards = [card_1, card_2, card_3]
    deck = Deck.new(cards)
    round = Round.new(deck)

    # binding.pry
    expect(round.percent_correct_by_category(:Geography)).to eq(0.0)
    round.take_turn("Juneau")
    round.take_turn("WRONG ANSWER")
    expect(round.percent_correct_by_category(:Geography)).to eq(100.0)
    expect(round.percent_correct_by_category(:STEM)).to eq(0.0)
    round.take_turn("North north west")
    expect(round.percent_correct_by_category(:Geography)).to eq(100.0)
    expect(round.percent_correct_by_category(:STEM)).to eq(50.0)
  end
end