require "./bj.rb"

describe "Game" do
  it 'has 8 decks' do
    s=Shoe.new
    s.cards.count.should eql 416
  end
  
  it 'can draw 30 cards' do
    s=Shoe.new
    30.times do |i|
      c=s.get_a_card
      c.v.should > 0 && c.v.should <= 13
      c.f.should >= 0 && c.f.should <= 3
    end
  end
  
  it 'can calc dealer first 2 cards' do
    s=Shoe.new
    dh=DealerHand.new
    c0=s.get_a_card
    c1=s.get_a_card
    dh.c0 c0
    dh.c1 c1
    dh.hand_value.should >= 4 && dh.hand_value.should <= 21
  end

  it 'can calc dealer total hand' do
    s=Shoe.new
    rm=RoundMaker.new s
    rm.dealer_hand
    rm.dh.cards.each{|c|  c.print}
    rm.dh.stand?.should == true
  end
end
