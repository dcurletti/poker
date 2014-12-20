require 'poker.rb'
require 'card'
require 'deck'
require 'hand'
require 'playa'

describe Card do
  subject(:card) {Card.new(1, :diamond)}
  it "has a value" do
    expect(card.value).to eq(1)
    expect(card.suit).to eq(:diamond)
  end
end

describe Deck do
  subject(:deck) {Deck.new}

  it "has 52 cards" do
    expect(deck.count).to eq(52)
  end

  describe "#draw" do
    it "draws random cards" do |variable|
      expect(deck.draw(5)).to_not eq(deck.draw(5))
    end

    it "takes cards from the deck" do
      deck.draw(5)
      expect(deck.count).to eq(47)
    end

    it "returns the cards" do
      expect(deck.draw(5).all?{|card| card.class == Card}).to equal(true)
    end
  end

end

describe Hand do

  describe "#best_hand" do
    cards = (10..14).inject([]){ |cards, i| [Card.new(i, :spades)] + cards }
    hand = Hand.new(cards)
    it "returns the best hand possible" do
      expect(hand.best_hand).to eq(8)
    end
  end

  describe "#pair?" do
    cards = [Card.new(2, :spades), Card.new(2, :diamonds), Card.new(3, :spades)]
    hand = Hand.new(cards)
    it "returns true if a pair is in the hand" do
      expect(hand.pair?).to eq(true)
    end
  end
  describe "#two_pair?" do
    cards = [Card.new(2, :spades), Card.new(2, :diamonds), Card.new(3, :spades), Card.new(3, :diamonds),  Card.new(3, :diamonds)]
    hand = Hand.new(cards)
    it "returns true if two pairs are in the hand" do
      expect(hand.two_pair?).to eq(true)
    end
  end

  describe "#three_of_a_kind?" do
    cards = [Card.new(2, :spades), Card.new(2, :diamonds), Card.new(2, :spades), Card.new(3, :diamonds)]
    hand = Hand.new(cards)
    it "returns true if three of a kind are in the hand" do
      expect(hand.three_of_a_kind?).to eq(true)
    end
  end

  describe "#straight?" do
    cards = [Card.new(2, :spades), Card.new(4, :diamonds), Card.new(3, :spades), Card.new(5, :diamonds), Card.new(6, :diamonds)]
    hand = Hand.new(cards)
    it "returns true a straight is in the hand" do
      expect(hand.straight?).to eq(true)
    end
  end

  describe "#flush?" do
    cards = [Card.new(5, :spades), Card.new(2, :spades), Card.new(3, :spades), Card.new(3, :spades)]
    hand = Hand.new(cards)
    it "returns true if all cards have the same suit" do
      expect(hand.flush?).to eq(true)
    end
  end

  describe "#full_house?" do
    cards = [Card.new(5, :spades), Card.new(5, :spades), Card.new(3, :spades), Card.new(3, :spades), Card.new(3, :spades)]
    hand = Hand.new(cards)
    it "returns true if three_of_a_king and pair?" do
      expect(hand.full_house?).to eq(true)
    end
  end

  describe "#straight_flush?" do
    cards = [Card.new(5, :spades), Card.new(6, :spades), Card.new(7, :spades), Card.new(8, :spades), Card.new(9, :spades)]
    hand = Hand.new(cards)
    it "returns true if hand contains a straight flush?" do
      expect(hand.straight_flush?).to eq(true)
    end
  end

  describe "#royal_flush?" do
    cards = [Card.new(10, :spades), Card.new(11, :spades), Card.new(12, :spades), Card.new(13, :spades), Card.new(14, :spades)]
    hand = Hand.new(cards)
    it "returns true if hand contains a royal flush?" do
      expect(hand.royal_flush?).to eq(true)
    end
  end
end

describe Playa do
  subject(:playa) { Playa.new(Deck.new, 100)}

  it "gets a new hand after initializing" do
    expect(playa.hand.count).to eq(5)

  end

  it "starts with a pot" do
    expect(playa.pot).to_not be_nil
  end

  describe "#discard" do
    it "exchanges the unwanted cards with new ones from the deck" do
      old_hand = playa.hand
      playa.discard([0,1,3])
      expect(playa.hand).to_not eq(old_hand)
    end
  end


end


  #
  # it "starts 5 cards" do
  #   expect(hand.cards.count).to eq(5)
  # end



  # describe "#exchange_cards" do
  #   it "raises an exception if more than 3"
  #     expect { hand.exchange_cards(4) }.to raise_error(ArgumentError)
  #
  #   it "it draws cards" do
  #     hand.exchange_cards(2)
  #     expect(hand.count).to eq(5)
  #   end
  #
  #   it "has new cards" do
  #
  #   end
