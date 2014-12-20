class Playa
  attr_reader :hand, :pot

  def initialize(deck, pot)
    @deck = deck
    @pot = pot
  end

  def discard
    puts "Which cards would you like to discard? (indices)"
    arr = gets.chomp.scan(/[0-4]/).map(&:to_i)
    arr.each {|i| hand.delete(i)}

    arr.count
  end

  def receive_cards(cards)
    hand += cards
  end

  def get_bet(amount, message)
    response = ""
    begin
      puts message
      response = gets.chomp
      return -1 if response == "fold"
      return 0 if response == "check"
      response = Integer(gets.chomp)
      raise ArgumentError if response < amount
    rescue ArgumentError => e
      puts "Not a valid bet"
      retry
    end

    response
  end

  def display_cards
    print @hand
  end

end
