class Deck
  attr_reader :cards
    
  def initialize(cards)
    @cards = cards
  end

  def count
    @cards.length
  end

  def cards_in_category(category)
    category_cards = @cards.select do |card|
      card.category == category
    end

    category_cards
  end
end