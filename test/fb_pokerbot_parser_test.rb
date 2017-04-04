require 'test_helper'

class FbPokerbotParserTest < ActiveSupport::TestCase

  def setup
    @seats = %w| utg utg1 utg2 utg3 lj hj co btn sb bb|
  end

  # card syntax
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

  # flop cards

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
  

  # Seat Syntax

  test "#seat_actions parses valid seat names, action and amounts" do
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

  test "#seat_actions handles all action as default" do
    result = FbPokerbotParser::MessageParser.new(".test seat_actions utg b 100 all call")
    assert_equal 2, result.actions.count
    expected = [
      {:seat=>"utg", :action=>:bet, :amount=>100}, 
      {:seat=>"all", :action=>:call, :amount=>nil}
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


  # def test_seat_action
  #   result = FbPokerbotParser::MessageParser.new(".test-action utg b 100")
  #   assert_equal 1, result.actions.count
  #   assert_equal 'utg', result.actions.first.fetch(:seat)
  #   assert_equal :bet, result.actions.first.fetch(:action)
  #   assert_equal 100, result.actions.first.fetch(:amount)

  #   result = FbPokerbotParser::MessageParser.new(".test-action utg1 bet 100")
  #   assert_equal 1, result.actions.count
  #   assert_equal 'utg1', result.actions.first.fetch(:seat)
  #   assert_equal :bet, result.actions.first.fetch(:action)
  #   assert_equal 100, result.actions.first.fetch(:amount)

  #   result = FbPokerbotParser::MessageParser.new(".test-action utg2 c")
  #   assert_equal 1, result.actions.count
  #   assert_equal 'utg2', result.actions.first.fetch(:seat)
  #   assert_equal :call, result.actions.first.fetch(:action)
  #   assert_nil result.actions.first.fetch(:amount)

  #   result = FbPokerbotParser::MessageParser.new(".test-action utg3 call")
  #   assert_equal 1, result.actions.count
  #   assert_equal 'utg3', result.actions.first.fetch(:seat)
  #   assert_equal :call, result.actions.first.fetch(:action)
  #   assert_nil result.actions.first.fetch(:amount)

  #   result = FbPokerbotParser::MessageParser.new(".test-action lj f")
  #   assert_equal 1, result.actions.count
  #   assert_equal 'lj', result.actions.first.fetch(:seat)
  #   assert_equal :fold, result.actions.first.fetch(:action)
  #   assert_nil result.actions.first.fetch(:amount)

  #   result = FbPokerbotParser::MessageParser.new(".test-action hj fold")
  #   assert_equal 1, result.actions.count
  #   assert_equal 'hj', result.actions.first.fetch(:seat)
  #   assert_equal :fold, result.actions.first.fetch(:action)
  #   assert_nil result.actions.first.fetch(:amount)

  #   result = FbPokerbotParser::MessageParser.new(".test-action co ch")
  #   p result.actions
  #   assert_equal 1, result.actions.count
  #   assert_equal 'co', result.actions.first.fetch(:seat)
  #   assert_equal :check, result.actions.first.fetch(:action)
  #   assert_nil result.actions.first.fetch(:amount)

  #   result = FbPokerbotParser::MessageParser.new(".test-action btn check")
  #   assert_equal 1, result.actions.count
  #   assert_equal 'btn', result.actions.first.fetch(:seat)
  #   assert_equal :check, result.actions.first.fetch(:action)
  #   assert_nil result.actions.first.fetch(:amount)

  #   result = FbPokerbotParser::MessageParser.new(".test-action bb r 2")
  #   assert_equal 1, result.actions.count
  #   assert_equal 'bb', result.actions.first.fetch(:seat)
  #   assert_equal :raise, result.actions.first.fetch(:action)
  #   assert_equal 2, result.actions.first.fetch(:amount)

  #   result = FbPokerbotParser::MessageParser.new(".test-action sb raise 12")
  #   assert_equal 1, result.actions.count
  #   assert_equal 'sb', result.actions.first.fetch(:seat)
  #   assert_equal :raise, result.actions.first.fetch(:action)
  #   assert_equal 12, result.actions.first.fetch(:amount)
  # end

  # def test_default_action_with_all_keyword
  #   result = FbPokerbotParser::MessageParser.new(".test-action all c")
  #   assert_equal 1, result.actions.count
  #   assert_equal 'all', result.actions.first.fetch(:seat)
  #   assert_equal :call, result.actions.first.fetch(:action)

  #   result = FbPokerbotParser::MessageParser.new(".test-action all call")
  #   assert_equal 1, result.actions.count
  #   assert_equal 'all', result.actions.first.fetch(:seat)
  #   assert_equal :call, result.actions.first.fetch(:action)

  #   result = FbPokerbotParser::MessageParser.new(".test-action all fold")
  #   assert_equal 1, result.actions.count
  #   assert_equal 'all', result.actions.first.fetch(:seat)
  #   assert_equal :fold, result.actions.first.fetch(:action)

  #   result = FbPokerbotParser::MessageParser.new(".test-action all f")
  #   assert_equal 1, result.actions.count
  #   assert_equal 'all', result.actions.first.fetch(:seat)
  #   assert_equal :fold, result.actions.first.fetch(:action)

  # end

  # def test_default_action_with_no_keyword
  #   result = FbPokerbotParser::MessageParser.new(".test dflt_action call")
  #   assert_equal 1, result.actions.count
  #   assert_equal 'all', result.actions.first.fetch(:seat)
  # end

  # def test_multiple_seat_actions 
  #   result = FbPokerbotParser::MessageParser.new(".test dflt_action sb raise 12 bb call utg1 f")
  #   assert_equal 3, result.actions.count
  #   assert_equal ['sb', 'bb', 'utg1'], result.actions.map {|x| x.fetch(:seat)}
  # end

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
