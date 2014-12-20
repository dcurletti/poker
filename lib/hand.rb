class Hand

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def best_hand
    hands = [royal_flush?,
    straight_flush?,
    full_house?,
    flush?,
    straight?,
    three_of_a_kind?,
    two_pair?,
    pair?]

    hands.each_with_index do |hand, i|
      return 8 - i if hand
    end

    0
  end

  def pair?
    cards.combination(2).each do |pair|
      return true if pair[0].value == pair[1].value
    end

    false
  end

  def two_pair?
    pairs = []
    cards.combination(2).each do |pair|
      pairs << pair[0].value if pair[0].value == pair[1].value && pairs[-1] != pair[0].value
    end

    pairs.count > 1

  end

  def three_of_a_kind?
    cards.combination(3).each do |combination|
      return true if combination[0].value == combination[1].value && combination[2].value == combination[1].value
    end

    false

  end

  def straight?
    sorted_cards = cards.sort_by {|card| card.value}
    sorted_cards.each_with_index do |card, i|
      next if i == 4
      return false unless card.value + 1 == sorted_cards[i+1].value
    end

    true
  end

  def flush?
    cards.all? {|card|  card.suit == cards[0].suit}
  end

  def full_house?
    two_pair? && three_of_a_kind?
  end

  def straight_flush?
    straight? && flush?

  end

  def royal_flush?
     straight_flush? && cards.all?{|card| card.value >= 10}
  end

  def render
    cards.each {|card| print card}
  end

end
