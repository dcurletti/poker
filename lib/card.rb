class Card
  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def to_s
    special_values = {14 => "A", 13 => "K", 12 => "Q", 11 => "J"}
    suits = {spades:♠, hearts:♥, diamonds:♦, clubs:♣}
    return "#{special_values[value]} #{suits[suit]}" if special_values.keys.include?(value)
    "#{value} #{suits[suit]}"
  end

end
