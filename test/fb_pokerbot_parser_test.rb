require 'test_helper'

class FbPokerbotParserTest < ActiveSupport::TestCase

  def setup
    @seats = %w| utg utg1 utg2 utg3 lj hj co btn sb bb|
  end

  # card 

  test "card parses single card and capitalize value, lowercases suit" do
    result = FbPokerbotParser::MessageParser.new(".test card 10h")
    assert_equal ['10h'], result.cards

    result = FbPokerbotParser::MessageParser.new(".test card aC")
    assert_equal ['Ac'], result.cards

    result = FbPokerbotParser::MessageParser.new(".test card Kd")
    assert_equal ['Kd'], result.cards
  end

  test "#card fails if not valid card syntax" do
    result = FbPokerbotParser::MessageParser.new(".test card bad")
    assert_equal [], result.cards
  end

  # hole-cards

  test "#hole_cards parses two cards with no space" do
    result = FbPokerbotParser::MessageParser.new(".test hole-cards 10h10d")
    assert_equal ['10h', '10d'], result.hole_cards
  end

  test "#hole_cards parses two cards with space" do
    result = FbPokerbotParser::MessageParser.new(".test hole-cards 10h 10d")
    assert_equal ['10h', '10d'], result.hole_cards
  end

  test "#hold_cards returns nothing if only 1 card" do
    result = FbPokerbotParser::MessageParser.new(".test hole-cards 10h")
    assert_equal [], result.hole_cards
  end

  test "#hold_cards returns two cards if more than 2 cards presented" do
    result = FbPokerbotParser::MessageParser.new(".test hole-cards 10h 5h 3D")
    assert_equal ['10h', '5h'], result.hole_cards
  end

  # flop-cards

  test "#flop parses 3 cards with spaces" do
    result = FbPokerbotParser::MessageParser.new(".test flop-cards 10h 5d 4c")
    assert_equal ["10h", "5d", "4c"], result.flop
  end

  test "#flop parses 3 cards with no spaces" do
    result = FbPokerbotParser::MessageParser.new(".test flop-cards asahkD")
    assert_equal ["As", "Ah", "Kd"], result.flop
  end

  test "#flop parses 3 cards with some spaces" do
    result = FbPokerbotParser::MessageParser.new(".test flop-cards 10h5d 4c")
    assert_equal ["10h", "5d", "4c"], result.flop

    result = FbPokerbotParser::MessageParser.new(".test flop-cards 10h 5d4c")
    assert_equal ["10h", "5d", "4c"], result.flop
  end
  

  # seat_actions

  test "#seat_actions parses all possible valid seat names, action and amounts" do
    @seats.each do |seat|
      result = FbPokerbotParser::MessageParser.new(".test seat_action #{seat} call")
      action = result.actions.first
      assert_equal seat, action.fetch(:seat)
    end

    FbPokerbotParser::MessageParser::ACTIONS.each_pair do |k, v|
      next if v == :bet || v == :raise
      result = FbPokerbotParser::MessageParser.new(".test seat_action bb #{k}")
      expected = {:seat => "bb", :action => v, :amount => nil}
      assert_equal expected, result.actions.first
    end

    result = FbPokerbotParser::MessageParser.new(".test seat_action utg b 100")
    expected = {:seat=>"utg", :action=>:bet, :amount=>100}
    assert_equal expected, result.actions.first
    
    result = FbPokerbotParser::MessageParser.new(".test seat_action utg bet 100")
    expected = {:seat=>"utg", :action=>:bet, :amount=>100}
    assert_equal expected, result.actions.first
    

    result = FbPokerbotParser::MessageParser.new(".test seat_action utg r 100")
    expected = {:seat=>"utg", :action=>:raise, :amount=>100}
    assert_equal expected, result.actions.first

    result = FbPokerbotParser::MessageParser.new(".test seat_action utg raise 100")
    expected = {:seat=>"utg", :action=>:raise, :amount=>100}
    assert_equal expected, result.actions.first
  end

  test "#seat_actions parses multiple actions" do
    result = FbPokerbotParser::MessageParser.new(".test seat_actions utg b 100 btn c sb fold")
    assert_equal 3, result.actions.count
    expected = [
      {:seat=>"utg", :action=>:bet, :amount=>100},
      {:seat=>"btn", :action=>:call, :amount=>nil},
      {:seat=>"sb", :action=>:fold, :amount=>nil}
    ]
    assert_equal expected, result.actions
  end

  test "#seat_actions handles all action without all keyword" do
    result = FbPokerbotParser::MessageParser.new(".test seat_actions utg b 100 c")
    assert_equal 2, result.actions.count
    expected = [
      {:seat=>"utg", :action=>:bet, :amount=>100}, 
      {:seat=>"all", :action=>:call, :amount=>nil}
    ]
    assert_equal expected, result.actions    
  end

  test "#seat_actions handles multiple actions with all keyword" do
    result = FbPokerbotParser::MessageParser.new(".test seat_actions utg b 100 all call btn raise 100 all fold")
    assert_equal 4, result.actions.count
    
    expected = [
      {:seat=>"utg", :action=>:bet, :amount=>100}, 
      {:seat=>"all", :action=>:call, :amount=>nil},
      {:seat=>"btn", :action=>:raise, :amount=>100},
      {:seat=>"all", :action=>:fold, :amount=>nil}
    ]
    assert_equal expected, result.actions    
  end

  test "#seat_actions handles multiple actions without all keyword" do
    result = FbPokerbotParser::MessageParser.new(".test seat_actions utg b 100 call btn raise 100  fold")
    assert_equal 4, result.actions.count
    
    expected = [
      {:seat=>"utg", :action=>:bet, :amount=>100}, 
      {:seat=>"all", :action=>:call, :amount=>nil},
      {:seat=>"btn", :action=>:raise, :amount=>100},
      {:seat=>"all", :action=>:fold, :amount=>nil}
    ]
    assert_equal expected, result.actions    
  end

  test "#seat_actions handles all action as default" do
    result = FbPokerbotParser::MessageParser.new(".test seat_actions utg b 100 all call")
    assert_equal 2, result.actions.count
    expected = [
      {:seat=>"utg", :action=>:bet, :amount=>100}, 
      {:seat=>"all", :action=>:call, :amount=>nil}
    ]
    assert_equal expected, result.actions    
  end

  test "#seat_actions with starting default action and multiple seats" do
    result = FbPokerbotParser::MessageParser.new(".test seat_actions call utg fold")
    assert_equal 2, result.actions.count
    expected = [
      {:seat=>"all", :action=>:call, :amount=>nil},
      {:seat=>"utg", :action=>:fold, :amount=>nil} 
    ]
    assert_equal expected, result.actions    
  end

  # default_actions

  test '#default_action parses default action with all keyword' do
    result = FbPokerbotParser::MessageParser.new(".test default_action all check")
    expected = {:seat=>"all", :action=>:check, :amount=>nil}
    assert_equal 1, result.actions.count
    assert_equal expected, result.actions.first
  end

  test '#default_action parses default action without all keyword' do
    result = FbPokerbotParser::MessageParser.new(".test default_action call")
    expected = {:seat=>"all", :action=>:call, :amount=>nil}
    assert_equal 1, result.actions.count
    assert_equal expected, result.actions.first
  end

  # blinds

  test "#blinds parses 10/20 properly" do
    result = FbPokerbotParser::MessageParser.new(".test blinds 10/20")
    assert_equal 10, result.blinds[:sb]
    assert_equal 20, result.blinds[:bb]
    assert_nil result.blinds[:ante]
  end

  test "#blinds parse 1000/2000/100 properly for tourneys" do
    result = FbPokerbotParser::MessageParser.new(".test blinds 1000/2000/100")
    assert_equal 1000, result.blinds[:sb]
    assert_equal 2000, result.blinds[:bb]
    assert_equal 100, result.blinds[:ante]
  end

  test "#blinds parse 10/20/40/50 straddle properly for cash games" do
    result = FbPokerbotParser::MessageParser.new(".test blinds 1/2/4/8")
    assert_equal 1, result.blinds[:sb]
    assert_equal 2, result.blinds[:bb]
    assert_equal [4,8], result.blinds[:straddle]
  end

  test "#big_blind parses and sets bb and sb properly" do
    result = FbPokerbotParser::MessageParser.new(".test big_blind bb 2")
    assert_equal 2, result.blinds[:bb]
    assert_equal 1, result.blinds[:sb]

    result = FbPokerbotParser::MessageParser.new(".test big_blind bb 5")
    assert_equal 5, result.blinds[:bb]
    assert_equal 2, result.blinds[:sb]
  end

  test "#small_blind parses and sets sb properly" do
    result = FbPokerbotParser::MessageParser.new(".test small_blind sb 2")
    assert_equal 2, result.blinds[:sb]
  end

  test "#ante parses and sets ante properly" do
    result = FbPokerbotParser::MessageParser.new(".test ante ante 100")
    assert_equal 100, result.blinds[:ante]
  end

  # # new hand

  # def test_new_hand_command_syntax 
  #   result = FbPokerbotParser::MessageParser.new("nh")
  #   assert_equal :new_hand, result.command
  #   p result.command

  #   result = FbPokerbotParser::MessageParser.new("new 2/5")
  #   assert_equal :new_hand, result.command
  #   p result.command

  #   result = FbPokerbotParser::MessageParser.new("n 2/5")
  #   assert_equal :new_hand, result.command
  #   p result.command
  # end

  # def test_new_hand_options_syntax
  # end

  # def test_amount
  #   result = FbPokerbotParser::MessageParser.new(".test amount 100")
  #   p result.amount
  # end


end
