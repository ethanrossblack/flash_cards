class CardGenerator
  def initialize(file)
    @file = file
    @cards = []
  end

  def cards
    data = File.open(@file)
    file_data = data.read.split("\n")
    file_data.each do |line|
      card = line.split(",")
      @cards << Card.new(card[0], card[1], card[2])
    end
    @cards
  end
end

