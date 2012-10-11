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
    card = nil
    if @cards.count >= 30
      card=@cards.pop
    end
    card
  end

end

class Hand

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

  def double?

  end


  def bet money

  end
end

class Person
  attr_accessor :money
  def initialize money
    @money = money
  end



end

