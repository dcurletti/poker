class Game
  attr_accessor :players

  def initialize(deck, players)
    @deck = deck
    @players = players
  end

  def play
    puts "Welcome to short poker"

    @pot = 0
    playing_players = players.dup

    #Fixed ante
    playing_players.each do |player|
      deal(player, 5)
      @pot += player.get_bet(5, "current ante is 5")
      puts player.hand.render
    end

    #First round bets
    get_bets()

    #Ask to switch cards
    playing_players.each { |player| deal(player, player.discard) }

    #Final round of betting
    get_bets()

    player_w_best_hand = nil
    playing_players.each do |player|
      player_w_best_hand = compare_hands(player_w_best_hand, player)
    end


  end

  def get_bets
    counter = 0
    current_bet = 0
    loop do
      playing_players.each do |player|
        bet = player.get_bet(current_bet)

        if bet = 0
          counter += 1
        elsif bet == -1
          playing_players.delete(player)
        elsif bet == current_bet
          @pot += current_bet
          counter += 1
        else
          @pot += current_bet
          counter = 0
        end

        break if counter > playing_players.count || playing_players.count == 1
      end
    end
  end

  def deal(player, num)
    player.receive_cards(deck.draw(num))
  end


  #takes two players and compares their hands
  def compare_hands
  end

end
