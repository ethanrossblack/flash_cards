

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
    if @turn_num == 0
      0.0
    else
      (number_correct / @turn_num.to_f * 100).round(1)
    end
  end

  def percent_correct_by_category(category)
    card_category_count = @turns.count do |turn|
      turn.card.category == category
    end
    if card_category_count == 0
      0.0
    else    
      (number_correct_by_category(category) / card_category_count.to_f * 100).round(1)
    end
  end
end