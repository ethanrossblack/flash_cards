class Round
  attr_reader :deck, :turns
  
  def initialize(deck)
    @deck = deck
    @turns = []
  end

  def current_card
    @deck.cards[@turns.length]
  end

  def take_turn(guess)
    turn = Turn.new(guess, current_card)
    @turns << turn
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
    if @turns.length == 0
      0.0
    else
      (number_correct / @turns.length.to_f * 100).round(1)
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