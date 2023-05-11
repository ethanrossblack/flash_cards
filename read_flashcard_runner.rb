require "./lib/card"
require "./lib/deck"
require "./lib/round"
require "./lib/turn"
require "./lib/card_generator"
require "pry"


filename = "cards.txt"
cards = CardGenerator.new(filename).cards

# Create deck
deck = Deck.new(cards)

# Create a round
round = Round.new(deck)

def start(round)
  # Print Introduction
  puts "Welcome! You're playing with #{round.deck.count} cards."
  puts "-------------------------------------------------"
  
  categories = []
  # Ask and Answer Questions
  round.deck.count.times do
    puts "This is card number #{round.turns.length + 1} of #{round.deck.count}"
    puts "Question: #{round.current_card.question}"
    categories << round.current_card.category
    answer = gets.chomp
    turn = round.take_turn(answer)
    puts turn.feedback
  end

  # Print final score
  puts "****** Game over! ******"
  final_score_text =  "You had #{round.number_correct} correct "
  # Address grammar when score is 1
  if round.number_correct == 1
    final_score_text << "guess "
  else
    final_score_text << "guesses "
  end
  final_score_text << "out of #{round.deck.count} for a total score of #{round.percent_correct.to_i}%."
  puts final_score_text

  # Print categories
  categories.uniq!.sort!
  categories.each do |category|
    puts category.to_s + " - " + round.percent_correct_by_category(category).to_i.to_s + "% correct"
  end
end

start(round)