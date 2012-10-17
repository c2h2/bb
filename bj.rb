# encoding: utf-8
class Card
  attr_accessor :v, :f, :id

  def initialize v, f, id
    @v=v
    @f=f
    @id = id
  end
  
  def print
    syms=[ "♦", "♣", "♥", "♠"]
    vals=[ "0","A","2","3","4","5","6","7","8","9","T","J","Q","K"]
    puts "#{syms[@f]} #{vals[@v]} #{@id}" 
  end
end

class Deck
  @@index||=0
  def self.get_a_deck
  #create a deck
    @cards = []  
    52.times do |i|
      @cards << Card.new(1 + i/4 , i%4, @@index)
      @@index +=1
    end 
    @cards.shuffle!
    @cards
  end

end

class Shoe
  attr_accessor :cards
  def initialize
    @cards=[]
    8.times do
      @cards<<Deck.get_a_deck
    end
    @cards.flatten!
    @cards.shuffle!
    @cards
  end

  def get_a_card
    @cards.pop
  end
  
  def low?
    @cards.count <= 20
  end
    

end

class Hand
  attr_reader :cards
  def initialize
    @cards = []
    @soft   = false
  end

  def hand_value
    value = 0
    @cards.each do |card|
      if card.v == 1 #ace
        if value >= 11
          @soft=false
          value += 1 
        else
          @soft=true
          value += 11
        end
      elsif card.v >= 10
        value += 10
        if @soft and value > 21
          @soft = false
          value -= 10
        end
      else
        value += card.v
        if @soft and value > 21
          value -= 10
        end
      end
    end
    value 
  end

  def bj?
    hand_value == 21 && @cards.count == 2
  end

  def busted?
    hand_value > 21
  end

  def soft?
    @soft 
  end

  def c0 c  
    @cards[0]=c
  end

  def c1 c
    @cards[1]=c
  end

end


class DealerHand < Hand
  def initialize
    super 
  end

  def stand?
    hand_value >= 17
  end

  def feed_card?
    !stand? 
  end

  def feed_card card
    if !busted?
      @cards << card
    end
  end
end

class PlayerHand < Hand
  def initialize

  end
  
  def hit?
    
  end
  
  def hit
    
  end

  def double?

  end
  
  def split?
    
  end
  
  def split
    
  end

  def bet money

  end
end

class Player
  attr_accessor :money
  def initialize money
    @money = money
  end

end

class GameMaker
  def initialize
    @s = Shoe.new
  end
  
  def run
    if @s.low?
      @s=Shoe.new #get a new deck
    end
  end
  
end

class RoundMaker
  attr_accessor :dh
  #get dealer hand
  def initialize shoe
    @s = shoe
    @dh = DealerHand.new
  end
  
  def player_bet
    
  end

  def player_hand
    
  end
  
  def dealer_hand
    @dh.c0 @s.get_a_card
    @dh.c1 @s.get_a_card
    while @dh.feed_card?
      @dh.feed_card @s.get_a_card
    end
    #puts @dh.hand_value
  end
end

class Strategy
  def initialize dealer_card
    @dc = dealer_card
  end
  
  def action
    
  end
end