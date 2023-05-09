class Turn
  attr_reader :card, :guess

  def initialize(guess,card)
    @guess = guess
    @card = card
  end

  def correct?
    @guess == card.answer ? true : false
  end

  def feedback
    @guess == card.answer ? "Correct." : "Incorrect"
  end
end

