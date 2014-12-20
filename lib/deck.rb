class Deck

  def initialize
    @cards = []
    [:spades, :diamonds, :hearts, :clubs].each do |suit|
      2.upto(14) do |value|
        @cards << Card.new(value, suit)
      end
    end

    @cards.shuffle
  end

  def count
    @cards.count
  end

  def draw(number)
    @cards.pop(number)
  end

end
