

class Round
  attr_reader :deck, :turns, :turn_num
  
  def initialize(deck)
    @deck = deck
    @turns = []
    @turn_num = 0
  end

  def current_card
    @deck.cards[@turn_num]
  end

  def take_turn(guess)
    turn = Turn.new(guess, current_card)
    @turns << turn
    @turn_num += 1
    turn
  end

  def number_correct
    correct_guesses = @turns.count do |turn|
      turn.correct? == true
    end
    correct_guesses
  end

  def number_correct_by_category(category)
    correct_guesses_by_category = @turns.count do |turn|
      turn.correct? == true and turn.card.category == category
    end
    correct_guesses_by_category
  end

  def percent_correct
    ((number_correct / @turns.count).to_f * 100).round(1)
  end

  def percent_correct_by_category(category)
    ((number_correct_by_category(category) / @turns.count).to_f * 100).round(1)
  end
end